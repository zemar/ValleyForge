//
//  QuestionListModel.m
//  ValleyForge
//
//  Created by MHoward2 on 7/25/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListModel.h"
#import "ExamItem.h"
#import "Exam.h"
#import "ExamRunItem.h"
#import "NSString+Extensions.m"
#import "ExamListTableViewController.h"

@interface QuestionListModel ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property NSMutableString *tempElement;
@property (nonatomic, strong) ExamItem *currentExamItem;
@property NSInteger questionNumber;
@property BOOL examExists;
@property (nonatomic, strong) NSString* activeExam;

@end

@implementation QuestionListModel

- (instancetype)initWithContext:(NSManagedObjectContext *)context {
    self = [super init];

    if (self) {
        
        self.context = context;
        
        if ( ![self checkForExam] ) {
            [self initializeDefaultExam];
        }
        self.questionNumber = 0;
        self.examExists = NO;
        
        // Receive notification on active exam selection
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveActiveExam:) name:@"ActiveExam" object:nil];
    }
    
    return self;
}

- (void)initializeDefaultExam {

    NSString *defaultExamFile = @"CitizenshipExamWI";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:defaultExamFile ofType:@"xml"];
    if (filePath) {
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
        parser.delegate = self;
        [parser parse];
        
    } else {
        NSError *error;
        [NSException raise:@"Unable to open default exam file" format:@"%@", [error localizedDescription]];
    }

}

- (void)addExam:(NSData *)examData {
    
    if (examData) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:examData];
        parser.delegate = self;
        [parser parse];
        
    } else {
        NSError *error;
        [NSException raise:@"Unable to read exam data" format:@"%@", [error localizedDescription]];
    }
    
}

- (void)receiveActiveExam:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"ActiveExam"]) {
        self.activeExam = [notification.userInfo objectForKey:@"activeExam"];
        NSLog(@"Active exam changed to: %@", self.activeExam);
    }
}

#pragma mark - Fetch from CoreData
- (NSArray *)storedExams {
    
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"Exam" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetching stored exams failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return result;
}

- (NSArray *)storedExamItems {
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamItem" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"examName CONTAINS[c] %@", [self.activeExam stringByTrimmingTabsAndNewline]];
    [request setPredicate:p];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    return result;
}

#pragma mark - Data parsing and checking
- (BOOL)checkForExam {
    BOOL examPresent = false;
    
    // Query CoreData for existing exam
    if ( [ [self storedExams] count] > 0 ) {
        examPresent = true;
    }
    
    return examPresent;
}

- (NSString *)question:(NSInteger)index {
    NSArray *examItems = [self storedExamItems];
    
    if (!examItems) {
        NSError *error;
        [NSException raise:@"Fetch question failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return [examItems[index] question];
}

- (NSString *)answer:(NSInteger)index {
    NSArray *examItems = [self storedExamItems];
    
    if (!examItems) {
        NSError *error;
        [NSException raise:@"Fetch answer failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return [examItems[index] answer];
}

- (void)dumpQuestions {
    NSArray *examItems = [self storedExamItems];
    
    if (!examItems) {
        NSError *error;
        [NSException raise:@"Fetch question failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    int i = 0;
    for(ExamItem *item in examItems) {
        NSLog(@"Question%d from CoreData: %@", i, item.question);
        i++;
    }
}

- (NSInteger)questionCount {
    NSArray *examItems = [self storedExamItems];
    
    if (!examItems) {
        NSError *error;
        [NSException raise:@"Fetch storedExamItems failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return [examItems count];
}

#pragma mark - NSXMLParser Delegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ( !self.examExists && [elementName isEqualToString:@"examItem"] ) {
        
        // Create CoreData ExamItem entry
        ExamItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"ExamItem" inManagedObjectContext:self.context];
        self.currentExamItem = item;
        self.currentExamItem.examName = [self.exam.examName stringByTrimmingTabsAndNewline];
        
    }
    
    if (!self.tempElement) {
        self.tempElement = [[NSMutableString alloc] init];
    }
    [self.tempElement setString:@""];
        
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.tempElement appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( [elementName isEqualToString:@"examName"]) {
        NSString *requestedExam = [self.tempElement stringByTrimmingTabsAndNewline];
        for (Exam* item in [self storedExams]) {
//            NSLog(@"%@", item.examName);
            if ([item.examName containsString:requestedExam] ) {
                self.examExists = YES;
            }
        }
        
        if ( !self.examExists) {
            // Create CoreData Exam entry
            self.exam = [NSEntityDescription insertNewObjectForEntityForName:@"Exam" inManagedObjectContext:self.context];
            self.exam.examName = [self.tempElement stringByTrimmingTabsAndNewline];
//            NSLog(@"ExamName: %@", self.exam.examName);

        } else {
            NSLog(@"%@ already exists in database", requestedExam);
        }
    }
    
    if ( !self.examExists && [elementName isEqualToString:@"question"] ) {
        self.currentExamItem.question = [self.tempElement stringByTrimmingTabs];
//        NSLog(@"question%ld: %@", (long)self.questionNumber, self.currentExamItem.question);
        self.questionNumber++;
    }
    
    if ( !self.examExists && [elementName isEqualToString:@"answer"] ) {
        self.currentExamItem.answer = [self.tempElement stringByTrimmingTabs];
//        NSLog(@"Answer: %@", self.currentExamItem.answer);
    }
    
    NSError *error;
    if ( ![self.context save:&error] ) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    
    // Reset tempElement
    [self.tempElement setString:@""];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSError *error;
    [NSException raise:@"XML parsing error occurred" format:@"%@", [error localizedDescription]];

}

#pragma mark - CoreData Delete
- (void)deleteExam:(NSString *)examName {

    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"Exam" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"examName CONTAINS[c] %@", [examName stringByTrimmingTabsAndNewline]];
    [request setPredicate:p];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    for (Exam *exam in result) {
        
        if ( [exam.examName stringByTrimmingTabsAndNewline] == [examName stringByTrimmingTabsAndNewline] ) {
            [self.context deleteObject:exam];
            NSLog(@"%@ object deleted", exam);
        }
    }
    
    request.entity = [NSEntityDescription entityForName:@"ExamItem" inManagedObjectContext:self.context];
    [request setPredicate:p];
    result = [self.context executeFetchRequest:request error:&error];
    
    for (ExamItem *item in result) {
        
        if ( [item.examName stringByTrimmingTabsAndNewline] == [examName stringByTrimmingTabsAndNewline] ) {
            [self.context deleteObject:item];
            NSLog(@"%@ object deleted", item);
        }
    }
    
    request.entity = [NSEntityDescription entityForName:@"ExamRunItem" inManagedObjectContext:self.context];
    [request setPredicate:p];
    result = [self.context executeFetchRequest:request error:&error];
    
    for (ExamRunItem *item in result) {
        
        if ( [item.examName stringByTrimmingTabsAndNewline] == [examName stringByTrimmingTabsAndNewline] ) {
            [self.context deleteObject:item];
            NSLog(@"%@ object deleted", item);
        }
    }
    
    if ( ![self.context save:&error] ) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
}

@end
