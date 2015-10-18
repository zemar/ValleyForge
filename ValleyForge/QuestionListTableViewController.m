//
//  QuestionListTableViewController.m
//  ValleyForge
//
//  Created by mike on 7/12/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListTableViewController.h"
#import "QuestionListTableView.h"
#import "AnswerViewController.h"
#import "QuestionListModel.h"
#import "ExamItem.h"
#import "QuestionListTableViewCell.h"
#import "NSString+Extensions.h"

@interface QuestionListTableViewController ()

@property (nonatomic) QuestionListTableView *qltv;
@property (strong, nonatomic) UIBarButtonItem *start;
@property (strong, nonatomic) UIBarButtonItem *stop;

@end

@implementation QuestionListTableViewController

- (instancetype)initWithContext:(NSManagedObjectContext*)context {
    self = [super init];
    
    if (self) {
        self = [self initWithStyle:UITableViewStylePlain];
        self.questionListModel = [[QuestionListModel alloc] initWithContext:context];
        self.examRunsModel = [[ExamRunsModel alloc] initWithContext:context];
        
        self.tabBarItem.title = @"Exam";
        self.tabBarItem.image = [UIImage imageNamed:@"exam"];
        
        self.start = [[UIBarButtonItem alloc] initWithTitle:@"Start"
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(start:)];
        
        self.stop = [[UIBarButtonItem alloc] initWithTitle:@"Stop"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(stop:)];
        self.navigationItem.leftBarButtonItem = self.start;
        
        self.started = false;
        
        // Receive notification on active exam selection
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveActiveExam:) name:@"ActiveExam" object:nil];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:style];
}

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.qltv = [[QuestionListTableView alloc] initWithFrame:frame];
    self.qltv.delegate = self;
    self.qltv.dataSource = self;
    self.view = self.qltv;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    [self.tableView registerClass:[QuestionListTableViewCell class] forCellReuseIdentifier:@"QuestionTableViewCell"];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dumpResults:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receiveActiveExam:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"ActiveExam"]) {
        self.activeExam = [notification.userInfo objectForKey:@"activeExam"];
    }
}

- (void)dumpResults:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DumpResults" object:self];
}

#pragma mark - Exam run
- (void)start:(id)sender {

    self.navigationItem.leftBarButtonItem = self.stop;
    self.runNumber = [self.examRunsModel fetchNextRunNumber:self.activeExam];
    NSLog(@"Started exam for %@ runNumber:%d", self.activeExam, self.runNumber);
    self.started = true;
}

- (void)stop:(id)sender {
    NSLog(@"Stopped exam");
    self.navigationItem.leftBarButtonItem = self.start;
    self.started = false;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    // If this is 0, dataSource methods are ignored!!
    return self.questionListModel.questionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    QuestionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionTableViewCell"];

    if (cell == nil ) {
        cell = [[QuestionListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"QuestionTableViewCell"];
    }
    
    NSString *questionText = [[self.questionListModel question:indexPath.section] stringByTrimmingTabs];
    cell.textLabel.text = questionText;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"question%ld", (long)indexPath.section + 1]];
    cell.section = indexPath.section;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)selection {
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)selection {
    UIView *v = [[UIView alloc] init];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AnswerViewController *avc = [[AnswerViewController alloc] init];
    avc.answer = [self.questionListModel answer:(NSInteger)indexPath.section];
    avc.examRunsModel = self.examRunsModel;
    avc.question = [[self.questionListModel question:indexPath.section] stringByTrimmingTabsAndNewline];
    avc.activeExam = self.activeExam;
    avc.runNumber = self.runNumber;
    avc.started = self.started;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:avc];
    
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    navController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    [self presentViewController:navController animated:YES completion:NULL];
}

@end
