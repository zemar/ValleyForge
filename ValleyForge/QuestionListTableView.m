//
//  QuestionListTableView.m
//  ValleyForge
//
//  Created by mike on 7/12/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListTableView.h"

@implementation QuestionListTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithRed:(72.0f/255.0f) green:(72.0f/255.0f) blue:(72.0f/255.0f) alpha:1.0f];
    self.rowHeight = 100.0;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.separatorColor = [UIColor blueColor];
    self.separatorEffect = [[UIBlurEffect alloc] init];
    self.separatorInset = UIEdgeInsetsMake(0, 50, 0, 50);

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
