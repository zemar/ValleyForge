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
        
        self.origFrame = CGRectNull;
        
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ( CGRectIsNull(self.origFrame) ) {
        self.origFrame = self.frame;
    }

    self.frame = CGRectMake(_origFrame.origin.x + 5, _origFrame.origin.y + 5, _origFrame.size.width - 10, _origFrame.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
