//
//  ExamResultsTableViewCell.h
//  ValleyForge
//
//  Created by Michael on 9/20/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamResultsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *runNumber;
@property (nonatomic, strong) UILabel *correct;
@property (nonatomic, strong) UILabel *incorrect;

@end
