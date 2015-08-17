//
//  ExamListTableView.m
//  ValleyForge
//
//  Created by mike on 8/16/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "ExamListTableView.h"

@implementation ExamListTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    NSLog(@"in initWithFrame");
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(72.0f/255.0f) green:(72.0f/255.0f) blue:(72.0f/255.0f) alpha:1.0f];
        self.rowHeight = 100.0;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        self.separatorColor = [UIColor blueColor];
        self.separatorEffect = [[UIBlurEffect alloc] init];
        self.separatorInset = UIEdgeInsetsMake(0, 50, 0, 50);
    }
    
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
