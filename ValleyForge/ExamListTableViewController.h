//
//  ExamListTableViewController.h
//  ValleyForge
//
//  Created by mike on 8/16/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"
#import "ExamRunsModel.h"

@interface ExamListTableViewController : UITableViewController

@property (strong, nonatomic) QuestionListModel *model;
@property (strong, nonatomic) NSString *activeExam;
@property (nonatomic, strong) ExamRunsModel *examRunsModel;

@end
