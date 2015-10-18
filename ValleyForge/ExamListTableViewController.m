//
//  ExamListTableViewController.m
//  ValleyForge
//
//  Created by mike on 8/16/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "ExamListTableViewController.h"
#import "ExamListTableViewCell.h"
#import "ExamListTableView.h"
#import "ExamResultsTableViewController.h"
#import "NSString+Extensions.h"

@interface ExamListTableViewController ()

@property (nonatomic) ExamListTableView *eltv;

@end

@implementation ExamListTableViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.tabBarItem.title = @"Exam List";
        self.tabBarItem.image = [UIImage imageNamed:@"list"];
        self.activeExam = nil;
    }
    
    return self;
}

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.eltv = [[ExamListTableView alloc] initWithFrame:frame];
    self.eltv.delegate = self;
    self.eltv.dataSource = self;
    self.view = self.eltv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[ExamListTableViewCell class] forCellReuseIdentifier:@"ExamListCell"];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dumpResults:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)dumpResults:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DumpResults" object:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger examCount = [[self.questionListModel storedExams] count];
    return examCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)selection {
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)selection {
    UIView *v = [[UIView alloc] init];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExamListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExamListCell"];
    
    if (cell == nil ) {
        cell = [[ExamListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ExamListCell"];
    }

    NSInteger row = indexPath.row;
    if (row <= [[self.questionListModel storedExams] count]) {
        NSArray *exams = [self.questionListModel storedExams];
        NSString *examName = [exams[row] examName];
        cell.textLabel.text = [examName stringByTrimmingTabsAndNewline];
    } else {
        cell.textLabel.text = @"No exam found";
    }
    // Default to first exam as the active
    if (!self.activeExam) {
        self.activeExam = cell.textLabel.text;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.activeExam forKey:@"activeExam"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ActiveExam" object:self userInfo:userInfo];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;

    if (row <= [[self.questionListModel storedExams] count]) {
        NSArray *exams = [self.questionListModel storedExams];
        NSString *examName = [exams[row] examName];
        self.activeExam = [examName stringByTrimmingTabs];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.activeExam forKey:@"activeExam"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ActiveExam" object:self userInfo:userInfo];

    } else {
        self.activeExam = @"No exam found";
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if (row <= [[self.questionListModel storedExams] count]) {
        NSArray *exams = [self.questionListModel storedExams];
        NSString *examName = [exams[row] examName];
        self.activeExam = [examName stringByTrimmingTabs];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.activeExam forKey:@"activeExam"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ActiveExam" object:self userInfo:userInfo];
        
    } else {
        self.activeExam = @"No exam found";
    }
    
    ExamResultsTableViewController *ertvc = [[ExamResultsTableViewController alloc] init];
    ertvc.examName  = self.activeExam;
    ertvc.examRunsModel = self.examRunsModel;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ertvc];
    
    navController.modalPresentationStyle = UIModalPresentationPopover;
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:navController animated:YES completion:NULL];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSString *examName;
    
    if (row <= [[self.questionListModel storedExams] count]) {
        NSArray *exams = [self.questionListModel storedExams];
        examName = [[exams[row] examName] stringByTrimmingTabs];
        
    }
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [self.questionListModel deleteExam:examName];
        
        [tableView reloadData];
    }
}

@end
