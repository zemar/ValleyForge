//
//  QuestionListTableViewController.m
//  ValleyForge
//
//  Created by mike on 7/12/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListTableViewController.h"
#import "QuestionListTableView.h"
#import "QuestionListTableViewCell.h"
#import "AnswerViewController.h"
#import "QuestionListModel.h"
#import "ExamItem.h"

@interface QuestionListTableViewController ()

@property (nonatomic) QuestionListTableView *qltv;
//@property (nonatomic, strong) UIBarButtonItem *infoButton;
//@property (nonatomic, strong) UIBarButtonItem *backButton;

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
    
//    self.infoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showInfo:)];
//    self.backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(homeScreen:)];
//
//    self.navigationItem.rightBarButtonItem = self.infoButton;

    [self.tableView registerNib:[UINib nibWithNibName:@"QuestionListTableViewCell" bundle:nil] forCellReuseIdentifier:@"QuestionListCell"];
}

//- (void)showInfo:(id)sender {
//    UIWebView *webView = [[UIWebView alloc] init];
//    webView.scalesPageToFit = YES;
//    
//    // Set the home URL
//    NSURL *url = [[NSURL alloc] initWithString:@"http://x-tic-systems.wix.com/exam-store"];
//
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//    self.view = webView;
//    
//    self.navigationItem.rightBarButtonItem = self.backButton;
//}
//
//- (void)homeScreen:(id)sender {
//    self.view = self.qltv;
//    self.navigationItem.rightBarButtonItem = self.infoButton;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    // If this is 0, dataSource methods are ignored!!
    return 15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    QuestionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionListCell" forIndexPath:indexPath];
    
    cell.questionLabel.text = [self.model question:indexPath.section];
    
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    
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
