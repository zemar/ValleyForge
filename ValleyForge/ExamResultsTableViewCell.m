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
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LinearGradient.png"]];

        self.runNumber = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width/3, self.frame.size.height)];
        self.runNumber.textAlignment = NSTextAlignmentLeft;
        self.runNumber.backgroundColor = [UIColor clearColor];
        self.runNumber.textColor = [UIColor whiteColor];
    
        self.correct = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, self.frame.size.width/3, self.frame.size.height)];
        self.correct.textAlignment = NSTextAlignmentLeft;
        self.correct.backgroundColor = [UIColor clearColor];
        self.correct.textColor = [UIColor whiteColor];
        
        self.incorrect = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, self.frame.size.width/3, self.frame.size.height)];
        self.incorrect.textAlignment = NSTextAlignmentLeft;
        self.incorrect.backgroundColor = [UIColor clearColor];
        self.incorrect.textColor = [UIColor whiteColor];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UITableView *tv = (UITableView *) self.superview.superview;
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(15, frame.origin.y, tv.frame.size.width - 30, frame.size.height);

    [self addSubview:self.runNumber];
    [self addSubview:self.correct];
    [self addSubview:self.incorrect];
    
}

@end
