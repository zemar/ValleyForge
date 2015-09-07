//
//  AnswerView.m
//  ValleyForge
//
//  Created by mike on 7/19/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "AnswerView.h"

@implementation AnswerView

- (instancetype)initWithFrame:(CGRect)frame labelText:(NSString *)text {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(72.0f/255.0f) green:(72.0f/255.0f) blue:(72.0f/255.0f) alpha:1.0f];

        self.label = [[UILabel alloc] initWithFrame:CGRectMake(
                                                               self.frame.origin.x + 20,
                                                               self.frame.origin.y + 100,
                                                               self.frame.size.width / 1.3,
                                                               self.frame.size.height / 1.3)];
        self.label.textColor = [UIColor blackColor];
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.label.numberOfLines = 0;
        
        [self addSubview:self.label];

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
