//
//  QuestionListTableViewCell.m
//  ValleyForge
//
//  Created by MHoward2 on 7/18/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListTableViewCell.h"

@interface QuestionListTableViewCell ()

@property CGRect origFrame;

@end

@implementation QuestionListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        self.textLabel.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 4;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
      
        self.imageView.image = [UIImage imageNamed:@"question"];
        
        self.layer.cornerRadius = 12;
        self.layer.masksToBounds = YES;
        
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
