//
//  SettingViewController.m
//  iHanzi
//
//  Created by Zhongwei on 14-2-1.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
{
    UITableView *tableview;
}
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableview.dataSource = self;
    tableview.delegate = self;
    
    [self.view addSubview:tableview];
    [tableview setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0*[self tableView:tableview numberOfRowsInSection:0])];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [tableview release];
    [super dealloc];
}

#pragma mark UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    static NSString *reuseIdentifier = @"SettingCell";
    switch (indexPath.row) {
        case 0:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            cell.textLabel.text = @"帮助信息";
            break;
            
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            cell.textLabel.text = @"版本检测";
            break;
            
        case 2:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            cell.textLabel.text = @"反馈意见";
            break;
            
        case 3:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            cell.textLabel.text = @"给我打分";
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
@end
