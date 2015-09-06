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

@interface QuestionListTableViewController ()

@property (nonatomic) QuestionListTableView *qltv;

@end

@implementation QuestionListTableViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self = [self initWithStyle:UITableViewStylePlain];
        self.model = [[QuestionListModel alloc] init];
        
        self.tabBarItem.title = @"Exam";
        self.tabBarItem.image = [UIImage imageNamed:@"exam"];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    // If this is 0, dataSource methods are ignored!!
    return self.model.questionCount;
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
    
    NSString *questionText = [[self.model question:indexPath.section] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.textLabel.text = questionText;
    cell.section = indexPath.section;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"question%ld", (long)indexPath.section]];

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
    avc.answer = [self.model answer:(NSInteger)indexPath.section];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:avc];
    
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    navController.modalTransitionStyle = UIModalTransitionStylePartialCurl;

    
    [self presentViewController:navController animated:YES completion:NULL];
}

@end
