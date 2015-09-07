//
//  AnswerView.h
//  ValleyForge
//
//  Created by mike on 7/19/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerView : UIView

@property (strong, nonatomic) UILabel *label;

- (instancetype)initWithFrame:(CGRect)frame labelText:(NSString *)text;

@end
