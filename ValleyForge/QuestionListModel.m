//
//  QuestionListModel.m
//  ValleyForge
//
//  Created by MHoward2 on 7/25/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListModel.h"
#import "ExamItem.h"

@import CoreData;

@interface QuestionListModel ()

@property NSMutableString *tempElement;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end

@implementation QuestionListModel

- (instancetype)init {
    self = [super init];


    if (self) {
        self.exam = [[NSMutableArray alloc] init];
        
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
    }
    
    return self;
}

- (BOOL)checkForExam {
    // Query CoreData for existing examß
    return false;
}

- (void)initializeDefaultExam {

    NSString *defaultExamFile = @"CitizenshipExam2014";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:defaultExamFile ofType:@"xml"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    parser.delegate = self;
    [parser parse];
    
}

#pragma mark - NSXMLParser Delegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ( [elementName isEqualToString:@"examItem"] ) {
        ExamItem *item = [[ExamItem alloc] init];
        [self.exam addObject:item];
        if (!self.tempElement) {
            self.tempElement = [[NSMutableString alloc] init];
        }
        [self.tempElement setString:@""];
        
        NSError *error;
        if ( ![self.context save:&error] ) {
            NSLog(@"Error saving: %@", [error localizedDescription]);
        }
            
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.tempElement appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( [elementName isEqualToString:@"question"] ) {
        [[self.exam lastObject] setQuestion:self.tempElement];
    }
    
    if ( [elementName isEqualToString:@"answer"] ) {
        [[self.exam lastObject] setAnswer:self.tempElement];
    }
    
    NSError *error;
    if ( ![self.context save:&error] ) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    
    [self.tempElement setString:@""];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSError *error;
    [NSException raise:@"XML parsing error occurred" format:@"%@", [error localizedDescription]];

}

@end
