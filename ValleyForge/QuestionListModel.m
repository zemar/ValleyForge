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
#import "NSString+trimLeadingCharacters.m"

@import CoreData;

@interface QuestionListModel ()

@property NSMutableString *tempElement;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) ExamItem *currentExamItem;
@property NSInteger questionNumber;

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
    }
    
    return self;
}

- (void)initializeDefaultExam {

    NSString *defaultExamFile = @"CitizenshipExam2014Wi";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:defaultExamFile ofType:@"xml"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    parser.delegate = self;
    [parser parse];
    
    self.exam.name = defaultExamFile;
}

#pragma mark - Fetch from CoreData
- (BOOL)checkForExam {
    BOOL examPresent = false;
    
    // Query CoreData for existing exam
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamItem" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if ( [result count] > 0 ) {
        examPresent = true;
    }
    
    return examPresent;
}

- (NSString *)question:(NSInteger)index {
    
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamItem" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"index = index"];
    [request setPredicate:p];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch question failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return [result[index] question];
    
}

- (NSString *)answer:(NSInteger)index {
    
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamItem" inManagedObjectContext:self.context];
    request.entity = e;
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    request.sortDescriptors = @[sd];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch answer failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return [result[index] answer];
    
}

- (void)dumpQuestions {
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamItem" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"index = index"];
    [request setPredicate:p];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch question failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    int i = 0;
    for(ExamItem *item in result) {
        NSLog(@"Question%d from CoreData: %@", i, item.question);
        i++;
    }
}

- (NSInteger)questionCount {
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamItem" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"index = index"];
    [request setPredicate:p];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch question failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return [result count];
}

#pragma mark - NSXMLParser Delegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"examName"]) {

        // Create CoreData Exam entry
        self.exam = [NSEntityDescription insertNewObjectForEntityForName:@"Exam" inManagedObjectContext:self.context];
    }
    
    if ( [elementName isEqualToString:@"examItem"] ) {
        
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
        self.exam.name = self.tempElement;
        NSLog(@"ExamName: %@", self.exam.name);
    }
    
    if ( [elementName isEqualToString:@"question"] ) {
        self.currentExamItem.question = [self.tempElement stringByTrimmingLeadingWhitespace];
        NSLog(@"question%ld: %@", (long)self.questionNumber, self.currentExamItem.question);
        self.questionNumber++;
    }
    
    if ( [elementName isEqualToString:@"answer"] ) {
        self.currentExamItem.answer = [self.tempElement stringByTrimmingLeadingWhitespace];
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
