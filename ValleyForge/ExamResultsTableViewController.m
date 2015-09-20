//
//  ExamResultsTableViewController.m
//  ValleyForge
//
//  Created by mike on 9/20/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "ExamResultsTableViewController.h"
#import "ExamResultsTableView.h"

@interface ExamResultsTableViewController ()

@end

@implementation ExamResultsTableViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[ExamResultsTableView alloc] initWithFrame:frame];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self.view action:@selector(dismiss:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UIColor *navBarColor = [UIColor colorWithRed:(10.0f/255.0f) green:(10.0f/255.0f) blue:(10.0f/255.0f) alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = navBarColor;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    
    
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
