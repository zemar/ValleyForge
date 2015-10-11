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
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(72.0f/255.0f) green:(72.0f/255.0f) blue:(72.0f/255.0f) alpha:1.0f];
        self.rowHeight = 50.0;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RadialGradient.png"]];
    }
   
    return self;
}

- (void)viewWillLoad {
    [self reloadData];
}

@end
