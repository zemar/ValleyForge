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
        UIColor *navBarColor = [UIColor colorWithRed:(10.0f/255.0f) green:(10.0f/255.0f) blue:(10.0f/255.0f) alpha:1.0f];
        self.navigationController.navigationBar.barTintColor = navBarColor;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        
        UIBarButtonItem *correct = [[UIBarButtonItem alloc] initWithTitle:@"Correct"
                                                                    style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(correct:)];
        UIBarButtonItem *incorrect = [[UIBarButtonItem alloc] initWithTitle:@"Incorrect"
                                                                    style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(incorrect:)];
        self.navigationItem.leftBarButtonItem = correct;
        self.navigationItem.rightBarButtonItem = incorrect;
        self.view = nil;
    }

    return self;
}

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.av = [[AnswerView alloc] initWithFrame:frame labelText:self.answer];
    self.view = self.av;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self.view action:@selector(dismiss:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
}

- (void)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)correct:(id)sender {
    [self dismiss:self];
}

- (void)incorrect:(id)sender {
    [self dismiss:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
