//
//  AnswerViewController.m
//  ValleyForge
//
//  Created by mike on 7/19/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerView.h"

@interface AnswerViewController ()

@property (nonatomic) AnswerView *av;

@end

@implementation AnswerViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        UIBarButtonItem *correct = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                 target:self
                                                                                 action:@selector(dismiss:)];
        self.navigationItem.rightBarButtonItem = correct;
        self.view = nil;
    }

    return self;
}

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.av = [[AnswerView alloc] initWithFrame:frame labelText:self.answer];
    self.view = self.av;
}

- (void)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
