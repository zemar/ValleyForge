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

// Used for the exam run
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *activeExam;
@property (nonatomic) NSInteger runNumber;

@end
