//
//  AnswerView.m
//  ValleyForge
//
//  Created by mike on 7/19/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "AnswerView.h"
#import "NSString+Extensions.h"

@implementation AnswerView

- (instancetype)initWithFrame:(CGRect)frame labelText:(NSString *)text {
    self = [super initWithFrame:frame];
    
    if (self) {

        UIImageView *outerBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"RadialGradient"]];
        UIImageView *innerBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"WhiteAged"]];

        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        self.translatesAutoresizingMaskIntoConstraints = YES;

        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + 20,
                                                               self.frame.origin.y + 100,
                                                               self.frame.size.width / 1.3,
                                                               self.frame.size.height / 1.3)];

        self.label.textColor = [UIColor blackColor];
        self.label.opaque = NO;
        self.label.attributedText = [[NSAttributedString alloc] initWithString:[text stringByTrimmingTabs]];
        self.label.numberOfLines = 0;
        self.label.translatesAutoresizingMaskIntoConstraints = NO;  // Got to have this!!!  Otherwise, extra constraints are added which conflict
        
        [self addSubview:outerBackground];
        [self addSubview:innerBackground];
        [self addSubview:self.label];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    NSDictionary *nameMap = @{@"label" : self.label};
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[label]-50-|" options:0 metrics:nil views:nameMap];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[label]-100-|" options:0 metrics:nil views:nameMap];
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
}

@end
