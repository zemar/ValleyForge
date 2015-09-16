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
#import "NSString+Extensions.m"
#import "ExamListTableViewController.h"

@import CoreData;

@interface QuestionListModel ()

@property NSMutableString *tempElement;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) ExamItem *currentExamItem;
@property NSInteger questionNumber;
@property BOOL examExists;
@property (nonatomic, strong) NSString* activeExam;

@end

@implementation QuestionListModel

- (instancetype)init {
    self = [super init];

    if (self) {
        
        // Initialize CoreData ValleyForge.xcdatamodeld
        self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        
        // SQLite file
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [documentDirectory stringByAppendingPathComponent:@"questionlists.data"];
        NSURL *storageURL = [NSURL fileURLWithPath:path];
        NSError *error;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storageURL options:nil error:&error]) {
            [NSException raise:@"SQLite Open Failure" format:@"%@", [error localizedDescription]];
        }
        
        // Create managed object context
        self.context = [[NSManagedObjectContext alloc] init];
        self.context.persistentStoreCoordinator = psc;

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
        
        self.exam.name = defaultExamFile;
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
        
        NSString *examString = [[NSString alloc] initWithData:examData encoding:NSUTF8StringEncoding];
        NSRange r1 = [examString rangeOfString:@"<examName>"];
        NSRange r2 = [examString rangeOfString:@"</examName>"];
        NSRange sub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
        
        self.exam.name = [examString substringWithRange:sub];
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
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"(index = index) AND (examName != %@)", self.activeExam];
    [request setPredicate:p];
    NSLog(@"Active exam is %@ with predicate: %@", self.activeExam, p);
    
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
    
    if ( self.examExists == NO && [elementName isEqualToString:@"examItem"] ) {
        
        // Create CoreData ExamItem entry
        ExamItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"ExamItem" inManagedObjectContext:self.context];
        self.currentExamItem = item;
        self.currentExamItem.examName = self.exam.name;
        
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
        if ( [[self storedExams] indexOfObject:self.tempElement] == NSNotFound) {
            // Create CoreData Exam entry
            self.exam = [NSEntityDescription insertNewObjectForEntityForName:@"Exam" inManagedObjectContext:self.context];
            self.exam.name = self.tempElement;
            NSLog(@"ExamName: %@", self.exam.name);

        } else {
            self.examExists = YES;
            NSLog(@"%@ already exists in database", self.exam.name);
        }
    }
    
    if ( [elementName isEqualToString:@"question"] ) {
        self.currentExamItem.question = [self.tempElement stringByTrimmingTabs];
        NSLog(@"question%ld: %@", (long)self.questionNumber, self.currentExamItem.question);
        self.questionNumber++;
    }
    
    if ( [elementName isEqualToString:@"answer"] ) {
        self.currentExamItem.answer = [self.tempElement stringByTrimmingTabs];
        NSLog(@"Answer: %@", self.currentExamItem.answer);
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

@end
