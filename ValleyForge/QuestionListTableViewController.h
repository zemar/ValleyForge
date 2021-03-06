//
//  QuestionListTableViewController.h
//  ValleyForge
//
//  Created by mike on 7/12/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamRunsModel.h"

@class QuestionListModel;
@class NSManagedObjectContext;

@interface QuestionListTableViewController : UITableViewController

@property (nonatomic, strong) QuestionListModel *questionListModel;
@property (strong, nonatomic) NSString *activeExam;
@property (nonatomic, strong) ExamRunsModel *examRunsModel;
@property (nonatomic) short runNumber;
@property (nonatomic) BOOL started;

- (instancetype)initWithContext:(NSManagedObjectContext*)context;

@end
