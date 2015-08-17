//
//  ExamListTableViewController.m
//  ValleyForge
//
//  Created by mike on 8/16/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "ExamListTableViewController.h"
#import "ExamListModel.h"
#import "ExamListTableViewCell.h"
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
    [self.tableView registerNib:[UINib nibWithNibName:@"ExamListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExamListCell"];

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
    ExamListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExamListCell" forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    
    if (row <= [self.model.examList count]) {
        cell.examLabel.text = self.model.examList[row];
    } else {
        cell.examLabel.text = @"No exam found";
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
