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

@interface GameSelectViewController ()

@end

@implementation GameSelectViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"选关";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return NUM_BLOCKS/NUM_BLOCK_PER_LINE+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [CustomGameSelectCell loadFromNib];
    }
    
    CustomGameSelectCell *customCell = (CustomGameSelectCell*)cell;
    
    [customCell setRowIndex:indexPath.row];
    
    [customCell setDelegate:self];
    
    if (indexPath.row == NUM_BLOCKS/NUM_BLOCK_PER_LINE) {
        [customCell.btn2 setHidden:YES];
        [customCell.btn3 setHidden:YES];
    }else {
        [customCell.btn2 setHidden:NO];
        [customCell.btn3 setHidden:NO];
    }
    
//    NSLog(@"cell btn1 %@",customCell.btn1.titleLabel.text);
//    
//    [customCell.btn1 setTitle:[NSString stringWithFormat:@"第%d关",NUM_BLOCK_PER_LINE*indexPath.row+1] forState:UIControlStateNormal];
//    [customCell.btn2 setTitle:[NSString stringWithFormat:@"第%d关",NUM_BLOCK_PER_LINE*indexPath.row+2] forState:UIControlStateNormal];
//    [customCell.btn3 setTitle:[NSString stringWithFormat:@"第%d关",NUM_BLOCK_PER_LINE*indexPath.row+3] forState:UIControlStateNormal];
    
    
    return cell;
}


#pragma mark GameSelectDelegate
- (void)didSelected:(NSUInteger)tag AtRow:(NSUInteger)row
{
    [[DataManager sharedInstance] setBlockIdx:3*row+tag];//设置第几关
    [[DataManager sharedInstance] setQuesIdx:0];
    
    GamePlayingViewController *controller = [[GamePlayingViewController alloc] initWithNibName:@"GamePlayingViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
