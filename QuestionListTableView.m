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
    
    self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    self.rowHeight = 100.0;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.separatorColor = [UIColor blueColor];
    self.separatorEffect = [[UIBlurEffect alloc] init];
    self.separatorInset = UIEdgeInsetsMake(0, 50, 0, 50);

    return self;
}

- (void)viewDidLoad {
    
    NSLog(@"viewDidLoad");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
