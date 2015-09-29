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
- (void)addResult:(NSString *)examName runNumber:(short)runNumber question:(NSString *)question correct:(BOOL)correct {
    
    // Create CoreData ExamRun entry
    ExamRunItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"ExamRunItem" inManagedObjectContext:self.context];
    item.examName = examName;
    item.runNumber = runNumber;
    item.question = question;
    item.correct = correct;
    
    NSLog(@"addResult: examName:%@ runNumber:%d question:%@ correct:%d", examName, runNumber, question, correct);
}

- (NSArray *)fetchAllResults:(NSString *)predicate {
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamRunItem" inManagedObjectContext:self.context];
    request.entity = e;
    
//    NSLog(@"fetchAllRsults with %@", predicate);
    
    NSPredicate *p = [NSPredicate predicateWithFormat:predicate];
    [request setPredicate:p];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    return result;
}

#pragma mark - Query wrappers
- (NSArray *)fetchResultsPerExam:(NSString *)examName {
    NSString *predicate = [NSString  stringWithFormat:@"examName CONTAINS[c] \"%@\"", [examName stringByTrimmingTabsAndNewline]];

//    NSLog(@"fetchResultsPerExam with %@", predicate);

    NSArray *result = [self fetchAllResults:predicate];
    return result;
}

- (NSArray *)fetchResultsPerExamAndRun:(NSString *)examName runNumber:(short)runNumber {
    NSString *predicate = [NSString  stringWithFormat:
                           @"(examName CONTAINS[c] \"%@\") AND (runNumber == \"%d\")",
                           [examName stringByTrimmingTabsAndNewline],
                           runNumber];

//    NSLog(@"fetchResultsPerExamAndRun with %@", predicate);

    NSArray *result = [self fetchAllResults:predicate];
    return result;
}

- (NSArray *)fetchResultsQuestion:(NSString *)examName runNumber:(short)runNumber question:(NSString *)question {
    NSString *predicate = [NSString  stringWithFormat:
                           @"(examName CONTAINS[c] \"%@\") AND (runNumber == \"%d\") AND (question CONTAINS[c] \"%@\")",
                           [examName stringByTrimmingTabsAndNewline],
                           runNumber,
                           question];

//    NSLog(@"fetchResultsQuestion with %@", predicate);
    
    NSArray *result = [self fetchAllResults:predicate];
    return result;
}

- (short)fetchRunNumber:(NSString *)examName {
    NSArray *result = [self fetchResultsPerExam:examName];
    NSMutableArray *runNumbers = [[NSMutableArray alloc] init];
    
    for (ExamRunItem *item in result) {
        [runNumbers addObject:[NSNumber numberWithInteger:item.runNumber]];
    }
    NSInteger max = [[runNumbers valueForKeyPath:@"@max.intValue"] intValue];

//    NSLog(@"fetchRunNumber with %@: %ld", examName, (long)max);

    return max;
}

@end
