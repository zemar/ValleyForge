//
//  ExamRunsModel.m
//  ValleyForge
//
//  Created by mike on 9/18/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "ExamRunsModel.h"
#import "ExamRunItem.h"
#import "NSString+Extensions.h"
@import CoreData;

@interface ExamRunsModel ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end

@implementation ExamRunsModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        // Initialize CoreData ValleyForge.xcdatamodeld
        self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        
        // SQLite file
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [documentDirectory stringByAppendingPathComponent:@"examruns.data"];
        NSURL *storageURL = [NSURL fileURLWithPath:path];
        NSError *error;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storageURL options:nil error:&error]) {
            [NSException raise:@"SQLite Open Failure" format:@"%@", [error localizedDescription]];
        }
        
        // Create managed object context
        self.context = [[NSManagedObjectContext alloc] init];
        self.context.persistentStoreCoordinator = psc;

    }
    
    return self;
}

#pragma mark - CoreData read/writes
- (void)addResult:(NSString *)examName runNumber:(NSInteger)runNumber question:(NSString *)question correct:(BOOL)correct {
    
    // Create CoreData ExamRun entry
    ExamRunItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"ExamRunItem" inManagedObjectContext:self.context];
    item.examName = examName;
    item.runNumber = runNumber;
    item.question = question;
    item.correct = correct;
    
}

- (NSArray *)fetchAllResults:(NSString *)predicate {
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamRunItem" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSPredicate *p = [NSPredicate predicateWithFormat:predicate];
    [request setPredicate:p];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    return result;
}

#pragma mark - Query wrappers
- (NSArray *)fetchResultsPerExam:(NSString *)examName {
    NSString *predicate = [NSString  stringWithFormat:@"examName CONTAINS[c] %@", [examName stringByTrimmingTabsAndNewline]];
    
    NSArray *result = [self fetchAllResults:predicate];
    return result;
}

- (NSArray *)fetchResultsPerExamAndRun:(NSString *)examName runNumber:(NSInteger)runNumber {
    NSString *predicate = [NSString  stringWithFormat:
                           @"(examName CONTAINS[c] %@) AND (runNumber == %ld)",
                           [examName stringByTrimmingTabsAndNewline],
                           (long)runNumber];
    
    NSArray *result = [self fetchAllResults:predicate];
    return result;
}

- (NSArray *)fetchResultsQuestion:(NSString *)examName runNumber:(NSInteger)runNumber question:(NSString *)question {
    NSString *predicate = [NSString  stringWithFormat:
                           @"(examName CONTAINS[c] %@) AND (runNumber == %ld) AND (question CONTAINS[c] %@)",
                           [examName stringByTrimmingTabsAndNewline],
                           (long)runNumber,
                           question];
    
    NSArray *result = [self fetchAllResults:predicate];
    return result;
}

@end
