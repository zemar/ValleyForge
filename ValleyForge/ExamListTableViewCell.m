//
//  ExamListTableViewCell.m
//  ValleyForge
//
//  Created by mike on 8/16/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "ExamListTableViewCell.h"

@interface ExamListTableViewCell ()

@property CGRect origFrame;

@end

@implementation ExamListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {

        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0);
        self.layer.cornerRadius = 12;
        self.layer.masksToBounds = YES;
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        self.accessoryType = UITableViewCellAccessoryDetailButton;
        
        self.textLabel.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 4;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        
        //    UIImage *questionImage = [UIImage imageNamed:@"question"];
        //    cell.imageView.image = questionImage;
        
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    UITableView *tv = (UITableView *) self.superview.superview;
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(5, frame.origin.y, tv.frame.size.width - 10, frame.size.height);
}

@end
