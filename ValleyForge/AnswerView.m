//
//  AnswerView.m
//  ValleyForge
//
//  Created by mike on 7/19/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "AnswerView.h"

@implementation AnswerView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.textLabel.text = @"Hi";
        self.backgroundColor = [UIColor redColor];
        NSLog(@"AnswerView.m: %@", self);
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
