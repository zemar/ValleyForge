//
//  AnswerViewController.h
//  ValleyForge
//
//  Created by mike on 7/19/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamRunsModel.h"

@interface AnswerViewController : UIViewController

@property (nonatomic) NSInteger index;
@property (nonatomic) NSString *answer;
@property (nonatomic, strong) ExamRunsModel *examRunsModel;

@end
