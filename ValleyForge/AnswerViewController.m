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

@end

@implementation AnswerViewController

- (instancetype)init {
    self = [super initWithNibName:@"AnswerView" bundle:nil];
    
    if (self) {
        UIBarButtonItem *correct = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                 target:self
                                                                                 action:@selector(dismiss:)];
        self.navigationItem.rightBarButtonItem = correct;
        NSLog(@"AnswerViewController.view: %@", self.view);
//        self.view.textLabel.text = @"Hi";  // Why isn't this working???
        
    }

    return self;
}

- (void)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
