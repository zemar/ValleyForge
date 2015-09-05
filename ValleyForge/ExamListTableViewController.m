//
//  ExamListTableViewController.m
//  ValleyForge
//
//  Created by mike on 8/16/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "ExamListTableViewController.h"
#import "ExamListModel.h"
//#import "ExamListTableViewCell.h"
#import "CustomTableViewCell.h"
#import "ExamListTableView.h"

@interface ExamListTableViewController ()

@property (nonatomic, strong) ExamListModel *model;
@property (nonatomic) ExamListTableView *eltv;

@end

@implementation ExamListTableViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.tabBarItem.title = @"Exam List";
        self.tabBarItem.image = [UIImage imageNamed:@"list"];

        self.model = [[ExamListModel alloc] init];
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
//    [self.tableView registerNib:[UINib nibWithNibName:@"ExamListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExamListCell"];
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"ExamListCell"];


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
    NSInteger examCount = [self.model.examList count];
    return examCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ExamListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExamListCell" forIndexPath:indexPath];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExamListCell" forIndexPath:indexPath];

    
    NSInteger row = indexPath.row;
    
//    if (row <= [self.model.examList count]) {
//        cell.examLabel.text = self.model.examList[row];
//    } else {
//        cell.examLabel.text = @"No exam found";
//    }

    if (cell == nil ) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ExamListCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    NSString *examText;
    if (row <= [self.model.examList count]) {
        examText = [self.model.examList[row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    } else {
        examText = @"No exam found";
    }
    
    cell.textLabel.text = examText;
    cell.textLabel.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 4;
    
    UIImage *questionImage = [UIImage imageNamed:@"question"];
    cell.imageView.image = questionImage;

    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

@end
