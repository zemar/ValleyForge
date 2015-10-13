//
//  QuestionListTableViewCell.m
//  ValleyForge
//
//  Created by MHoward2 on 7/18/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListTableViewCell.h"

@interface QuestionListTableViewCell ()


@end

@implementation QuestionListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        self.textLabel.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 4;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
      
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LinearGradient.png"]];
        
        self.layer.cornerRadius = 12;
        self.layer.masksToBounds = YES;

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    UITableView *tv = (UITableView *) self.superview.superview;
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(15, frame.origin.y, tv.frame.size.width - 30, frame.size.height);
    self.imageView.frame = CGRectMake(20,30,28,28);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
