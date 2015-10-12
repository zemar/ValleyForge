//
//  AnswerView.m
//  ValleyForge
//
//  Created by mike on 7/19/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "AnswerView.h"
#import "NSString+Extensions.h"

@interface AnswerView()

@property (nonatomic, strong) UIImageView *outerBackground;
@property (nonatomic, strong) UIImageView *innerBackground;
@property (nonatomic, strong) NSString *answerText;

@end

@implementation AnswerView

- (instancetype)initWithFrame:(CGRect)frame labelText:(NSString *)text {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.answerText = text;
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.translatesAutoresizingMaskIntoConstraints = YES;

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.outerBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"RadialGradient"]];
    self.outerBackground.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.outerBackground];

    
    self.innerBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"WhiteAged"]];
    self.innerBackground.frame = CGRectMake(self.frame.origin.x + 50, self.frame.origin.y + 20, self.frame.size.width - 100, self.frame.size.height - 100);
    [self.outerBackground addSubview:self.innerBackground];

    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + 20,
                                                           self.frame.origin.y + 100,
                                                           self.frame.size.width / 1.3,
                                                           self.frame.size.height / 1.3)];
    
    self.label.textColor = [UIColor blackColor];
    self.label.opaque = NO;
    self.label.attributedText = [[NSAttributedString alloc] initWithString:[self.answerText stringByTrimmingTabs]];
    self.label.numberOfLines = 0;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;  // Got to have this!!!  Otherwise, extra constraints are added which conflict
    [self.innerBackground addSubview:self.label];
    
    NSDictionary *nameMap = @{@"label" : self.label};
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[label]-50-|" options:0 metrics:nil views:nameMap];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[label]-100-|" options:0 metrics:nil views:nameMap];
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
}

@end
