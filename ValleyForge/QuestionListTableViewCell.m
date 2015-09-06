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
      
        self.layer.cornerRadius = 12;
        self.layer.masksToBounds = YES;
        
        self.origFrame = CGRectNull;
//        NSLog(@"Init origFrame for section %ld: %f %f %f %f", (long)self.section, self.origFrame.origin.x, self.origFrame.origin.y, self.origFrame.size.width, self.origFrame.size.height);
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    


//    if ( CGRectIsNull(self.origFrame) ) {
//        self.origFrame = self.frame;
//        NSLog(@"layoutSubviews origFrame for section %ld: %f %f %f %f", (long)self.section, self.origFrame.origin.x, self.origFrame.origin.y, self.origFrame.size.width, self.origFrame.size.height);
//    }
//    
//    self.frame = CGRectMake(_origFrame.origin.x + 5, _origFrame.origin.y, _origFrame.size.width - 10, _origFrame.size.height);
//    NSLog(@"self.frame for section %ld: %f %f %f %f", (long)self.section, self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
