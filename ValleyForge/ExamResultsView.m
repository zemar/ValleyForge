//
//  ExamResultsView.m
//  ValleyForge
//
//  Created by mike on 9/20/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "ExamResultsView.h"

@implementation ExamResultsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(72.0f/255.0f) green:(72.0f/255.0f) blue:(72.0f/255.0f) alpha:1.0f];
        self.translatesAutoresizingMaskIntoConstraints = YES;
        
        
//        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + 20,
//                                                               self.frame.origin.y + 100,
//                                                               self.frame.size.width / 1.3,
//                                                               self.frame.size.height / 1.3)];
//        
//        self.label.textColor = [UIColor blackColor];
//        self.label.backgroundColor = [UIColor whiteColor];
//        self.label.attributedText = [[NSAttributedString alloc] initWithString:[text stringByTrimmingTabs]];
//        self.label.numberOfLines = 0;
//        self.label.translatesAutoresizingMaskIntoConstraints = NO;  // Got to have this!!!  Otherwise, extra constraints are added which conflict
//        
//        [self addSubview:self.label];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
//    NSDictionary *nameMap = @{@"label" : self.label};
//    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[label]-50-|" options:0 metrics:nil views:nameMap];
//    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[label]-100-|" options:0 metrics:nil views:nameMap];
//    [self addConstraints:horizontalConstraints];
//    [self addConstraints:verticalConstraints];
}

@end
