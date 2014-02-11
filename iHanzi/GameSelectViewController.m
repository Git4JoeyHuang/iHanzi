//
//  GameSelectViewController.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-28.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "GameSelectViewController.h"
#import "CustomGameSelectCell.h"
#import "GamePlayingViewController.h"
#import "DataManager.h"

#define NUM_BLOCKS 100
#define NUM_BLOCK_PER_LINE 3
#define NUM_QUESTION 5
#define NUM_CHOICE 2

#define total_blocks 100
#define blocks_per_page 12
#define total_pages 9
#define rows_per_page 4

@interface GameSelectViewController ()
{
    UIScrollView *scrollView;
    UIPageControl *pageIndicator;
}

@end

@implementation GameSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    for (UIView* tableview in scrollView.subviews) {
        if ([tableview isKindOfClass:[UITableView class]]) {
            [(UITableView*)tableview reloadData];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"选关";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //add subview scrollview
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+20 , 320, 380)];
    [scrollView setPagingEnabled:YES];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    
    /*
     每页18关
     一共100关
     所以
     #define total_blocks 100
     #define blocks_per_page 12
     #define total_pages 9
     */
    
    for (int i=0; i<total_pages; ++i) {
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectZero];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tag = i;
        tableview.scrollEnabled = NO;
        
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.allowsSelection = NO;
        
        tableview.backgroundColor = [UIColor clearColor];
        tableview.backgroundView = nil;
        
        CGRect frame = scrollView.bounds;
        frame.origin.x += i*frame.size.width;
        tableview.frame = frame;
        
        [scrollView addSubview:tableview];
        
        [tableview release];
    }
    
    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width*total_pages, scrollView.bounds.size.height)];
    [scrollView setContentOffset:CGPointZero];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = CGRectMake(0.0, 0.0, 26.0, 23.0);
    
    [backButton setImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    
    [backButton setImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateSelected];
    
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;

    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    [temporaryBarButtonItem release];
    
    //set Background image
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    //UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.jpg"]];
    //[bgView setImage:[UIImage imageNamed:@"bg2.jpg"]];
    //[bgView setFrame:self.view.bounds];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];

}

//-(void)blockSelected:(UIGestureRecognizer*)tap
//{
//    GameSelectingButton* btn = (GameSelectingButton*)tap.view;
//    
//}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView.tag==total_pages-1) {
        return 2;
    }
    return rows_per_page;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int pageIndex = tableView.tag;
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [CustomGameSelectCell loadFromNib];
    }
    
    CustomGameSelectCell *customCell = (CustomGameSelectCell*)cell;
    
//    [customCell.btn1 addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blockSelected:)] autorelease] ];
//    [customCell.btn2 addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blockSelected:)] autorelease] ];
//    [customCell.btn3 addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blockSelected:)] autorelease] ];
    
    [customCell setRowIndex: pageIndex*rows_per_page + indexPath.row];
    [customCell setTableviewIndex:tableView.tag];
    
    [customCell setDelegate:self];
    
    if (tableView.tag==total_pages-1 && indexPath.row == 1) {
        [customCell.btn2 setHidden:YES];
        [customCell.btn3 setHidden:YES];
    }
    
//    NSLog(@"cell btn1 %@",customCell.btn1.titleLabel.text);
//    
//    [customCell.btn1 setTitle:[NSString stringWithFormat:@"第%d关",NUM_BLOCK_PER_LINE*indexPath.row+1] forState:UIControlStateNormal];
//    [customCell.btn2 setTitle:[NSString stringWithFormat:@"第%d关",NUM_BLOCK_PER_LINE*indexPath.row+2] forState:UIControlStateNormal];
//    [customCell.btn3 setTitle:[NSString stringWithFormat:@"第%d关",NUM_BLOCK_PER_LINE*indexPath.row+3] forState:UIControlStateNormal];
    
    
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

#pragma mark GameSelectDelegate
- (void)didSelected:(NSUInteger)tag AtRow:(NSUInteger)row
{
    [[DataManager sharedInstance] setBlockIdx:3*row+tag];//设置第几关
    [[DataManager sharedInstance] setQuesIdx:0];
    
    GamePlayingViewController *controller = [[GamePlayingViewController alloc] initWithBlockIndex:3*row+tag];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
}

-(void)didSelected:(NSUInteger)tag AtRow:(NSUInteger)row InTableView:(NSUInteger)table
{
    [[DataManager sharedInstance] setBlockIdx: 3*row +tag];//设置第几关
    [[DataManager sharedInstance] setQuesIdx:0];
    
    GamePlayingViewController *controller = [[GamePlayingViewController alloc] initWithBlockIndex:3*row+tag];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
}


- (void)dealloc {
    [scrollView release];
    [pageIndicator release];
    [super dealloc];
}
@end
