//
//  QuestionListTableViewCell.m
//  ValleyForge
//
//  Created by MHoward2 on 7/18/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListTableViewCell.h"

@implementation QuestionListTableViewCell

- (void)awakeFromNib {
    [self.textLabel setFont:[UIFont fontWithName:@"Apple Symbols" size:12.0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
