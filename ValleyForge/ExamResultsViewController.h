//
//  ExamResultsViewController.h
//  ValleyForge
//
//  Created by mike on 9/20/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamRunsModel.h"

@interface ExamResultsViewController : UIViewController

@property (nonatomic, strong) ExamRunsModel *examRunsModel;
@property (nonatomic, strong) NSString *examName;

@end
