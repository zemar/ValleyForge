//
//  ExamStoreViewController.h
//  ValleyForge
//
//  Created by mike on 8/15/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListTableViewController.h"

@interface ExamStoreViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) QuestionListModel *model;

@end
