//
//  ExamResultsTableView.m
//  ValleyForge
//
//  Created by mike on 9/20/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "ExamResultsTableView.h"

@implementation ExamResultsTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
       
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RadialGradient"]];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
