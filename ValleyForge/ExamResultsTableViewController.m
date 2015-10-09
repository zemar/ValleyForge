//
//  ExamResultsTableViewController.m
//  ValleyForge
//
//  Created by mike on 9/20/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "ExamResultsTableViewController.h"
#import "ExamResultsTableView.h"
#import "ExamResultsTableViewCell.h"
#import "ExamRunItem.h"

@interface ExamResultsTableViewController ()

@property (nonatomic, strong) ExamResultsTableView *ertv;

@end

@implementation ExamResultsTableViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self = [self initWithStyle:UITableViewStylePlain];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:style];
}

- (void)loadView {
    [super loadView];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.ertv = [[ExamResultsTableView alloc] initWithFrame:frame];
    self.ertv.delegate = self;
    self.ertv.dataSource = self;
    self.view  = self.ertv;

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self.view action:@selector(dismiss:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UIColor *navBarColor = [UIColor colorWithRed:(10.0f/255.0f) green:(10.0f/255.0f) blue:(10.0f/255.0f) alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = navBarColor;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ExamResultsTableViewCell class] forCellReuseIdentifier:@"ExamResultsCell"];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dumpResults:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [self.view addGestureRecognizer:tap];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)dumpResults:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DumpResults" object:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    short runNumber = [self.examRunsModel fetchRunNumbers:self.examName];
    return runNumber;
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
    ExamResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExamResultsCell"];
    
    if (cell == nil ) {
        cell = [[ExamResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ExamResultsCell"];
    }
    
    int correctCount = 0;
    int incorrectCount = 0;
    NSArray *resultsPerExam = [self.examRunsModel fetchResultsPerExam:self.examName];
    for (ExamRunItem *item in resultsPerExam) {
        if (item.runNumber == indexPath.row + 1) {
            if (item.correct) {
                correctCount++;
            } else {
                incorrectCount++;
            }
        }
    }
    
    cell.runNumber.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    cell.correct.text = [NSString stringWithFormat:@"%d", correctCount];
    cell.incorrect.text = [NSString stringWithFormat:@"%d", incorrectCount];
    
    return cell;
}

@end
