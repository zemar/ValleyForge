//
//  ExamResultsTableViewCell.m
//  ValleyForge
//
//  Created by Michael on 9/20/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "ExamResultsTableViewCell.h"

@implementation ExamResultsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        
        self.runNumber = [[UILabel alloc] init];
        self.correct = [[UILabel alloc] init];
        self.incorrect = [[UILabel alloc] init];

        self.runNumber.textColor = [UIColor whiteColor];
        self.runNumber.translatesAutoresizingMaskIntoConstraints = NO;
        self.correct.textColor = [UIColor whiteColor];
        self.correct.textColor = [UIColor whiteColor];

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UITableView *tv = (UITableView *) self.superview.superview;
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(5, frame.origin.y, tv.frame.size.width - 10, frame.size.height);

    [self.contentView addSubview:self.runNumber];
    [self.contentView addSubview:self.correct];
    [self.contentView addSubview:self.incorrect];
}

- (void)viewWillAppear {
   
}

@end
