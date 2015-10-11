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
    
    if (self) {
        self.rowHeight = 100.0;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        self.separatorColor = [UIColor blueColor];
        self.separatorEffect = [[UIBlurEffect alloc] init];
        self.separatorInset = UIEdgeInsetsMake(0, 50, 0, 50);
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RadialGradient"]];
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
