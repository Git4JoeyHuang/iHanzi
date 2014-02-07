//
//  NewsViewController.m
//  iHanzi
//
//  Created by Zhongwei on 14-2-1.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()
{
    UITableView *tableview;
    NSMutableArray* newsArray;
}
@end

@implementation NewsViewController

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
    
    newsArray = [[NSMutableArray alloc] init];
    [self initNewsData];
    
    [self adjustTableviewFrame];
}

-(void)initNewsData
{
    for(int i=0;i<50;++i)
    {
        [newsArray addObject:[NSString stringWithFormat:@"第%d期战报",i+1]];
    }
}

-(void)adjustTableviewFrame
{
    CGFloat visibleMaxHeight = self.view.frame.size.height - 50.0;
    CGRect frame = tableview.frame;
    if ([self tableView:tableview numberOfRowsInSection:0]*44.0<visibleMaxHeight) {
        frame.size.height = [self tableView:tableview numberOfRowsInSection:0]*44.0;
    }else{
        frame.size.height = visibleMaxHeight;
    }
    tableview.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [tableview release];
    [newsArray release];
    
    [super dealloc];
}

#pragma mark UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!newsArray) {
        return 0;
    }
    return newsArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentifier = @"newsCell";
    UITableViewCell* cell = [tableview dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [newsArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"点击查看";
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
@end
