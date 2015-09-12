//
//  ExamStoreViewController.m
//  ValleyForge
//
//  Created by mike on 8/15/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "ExamStoreViewController.h"

@interface ExamStoreViewController ()

@end

@implementation ExamStoreViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        UIWebView *webView = [[UIWebView alloc] init];
        webView.scalesPageToFit = YES;
        
        // Set the home URL
        NSURL *url = [[NSURL alloc] initWithString:@"http://xtic.x10host.com/vf/"];
        
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        self.view = webView;
        
        self.tabBarItem.title = @"Exam Store";
        self.tabBarItem.image = [UIImage imageNamed:@"store"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
