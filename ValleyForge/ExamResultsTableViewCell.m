//
//  ExamResultsTableViewCell.m
//  ValleyForge
//
//  Created by Michael on 9/20/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "ExamResultsTableViewCell.h"

@implementation ExamResultsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        
        self.runNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width / 3, self.frame.size.height)];
        self.correct = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + self.frame.size.width / 3, self.frame.origin.y, self.frame.size.width / 3, self.frame.size.height)];
        self.incorrect = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + 2 * (self.frame.size.width / 3), self.frame.origin.y, self.frame.size.width / 3, self.frame.size.height)];

        self.runNumber.textColor = [UIColor whiteColor];
        self.correct.textColor = [UIColor whiteColor];
        self.incorrect.textColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UITableView *tv = (UITableView *) self.superview.superview;
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(5, frame.origin.y, tv.frame.size.width - 10, frame.size.height);

    [self addSubview:self.runNumber];
    [self addSubview:self.correct];
    [self addSubview:self.incorrect];
    
    //    NSDictionary *nameMap = @{@"label" : self.label};
    //    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[label]-50-|" options:0 metrics:nil views:nameMap];
    //    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[label]-100-|" options:0 metrics:nil views:nameMap];
    //    [self addConstraints:horizontalConstraints];
    //    [self addConstraints:verticalConstraints];
}

@end
