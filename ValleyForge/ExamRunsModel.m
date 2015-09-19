//
//  ExamRunsModel.m
//  ValleyForge
//
//  Created by mike on 9/18/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "ExamRunsModel.h"
#import "ExamRunItem.h"
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

- (void)correctAnswer:(NSString *)examName question:(NSString *)question correct:(BOOL)correct {
    
    // Create CoreData ExamRun entry
    ExamRunItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"ExamRunItem" inManagedObjectContext:self.context];
    item.examName = examName;
    item.question = question;
    item.correct = correct;
    
}

@end
