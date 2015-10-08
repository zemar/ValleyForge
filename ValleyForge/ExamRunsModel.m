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

@interface ExamRunsModel ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation ExamRunsModel

- (instancetype)initWithContext:(NSManagedObjectContext *)context {
    self = [super init];
    
    if (self) {
        
        self.context = context;
      
        // Receive notification on active exam selection
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dumpAllResults:) name:@"DumpResults" object:nil];
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
    
    // Save the object to persistent store
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
//    NSLog(@"addResult: examName:%@ runNumber:%d question:%@ correct:%d", examName, runNumber, question, correct);
}

- (void)dumpAllResults:(NSNotification *)notification {
    
    if ( ![[notification name] isEqualToString:@"DumpResults"] ) {
        return;
    }
    
    // CoreData read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ExamRunItem" inManagedObjectContext:self.context];
    request.entity = e;
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    NSLog(@"Run Summary:");
    for (ExamRunItem *item in result) {
        NSLog(@"Name: %@ run: %d correct:%d\n", item.examName, item.runNumber, item.correct);
    }
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

- (short)fetchNextRunNumber:(NSString *)examName {
    NSArray *result = [self fetchResultsPerExam:examName];
    NSMutableArray *runNumbers = [[NSMutableArray alloc] init];
    
    for (ExamRunItem *item in result) {
        [runNumbers addObject:[NSNumber numberWithInteger:item.runNumber]];
    }
    NSInteger max = [[runNumbers valueForKeyPath:@"@max.intValue"] intValue];

//    NSLog(@"fetchRunNumber with %@: %ld", examName, (long)max);

    short nextRun = 0;
    if (runNumbers.count != 0) {
        nextRun = max + 1;
    }
    
    return nextRun;
}

- (short)fetchRunNumbers:(NSString *)examName {
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
