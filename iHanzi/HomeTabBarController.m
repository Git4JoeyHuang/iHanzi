//
//  HomeTabBarController.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-28.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "HomeTabBarController.h"
#import "UserViewController.h"
#import "CustomTabViewController.h"
#import "SettingViewController.h"
#import "NewsViewController.h"

@interface HomeTabBarController ()
@property (retain, nonatomic) IBOutlet UITabBarItem *ItemNews;
@property (retain, nonatomic) IBOutlet UITabBarItem *ItemUser;
@property (retain, nonatomic) IBOutlet UITabBarItem *ItemSetting;

@end

@implementation HomeTabBarController

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
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray* ctr_array = [NSMutableArray array];
    
    NewsViewController *ctr_news = [[NewsViewController alloc] init];
    //ctr_news.view.backgroundColor = [UIColor redColor];
    [ctr_array addObject:ctr_news];
    [ctr_news release];
    
    UserViewController *ctr_user = [[UserViewController alloc] init];
    ctr_user.view.backgroundColor = [UIColor blueColor];
    [ctr_array addObject:ctr_user];
    [ctr_user release];
   
    SettingViewController *ctr_setting = [[SettingViewController alloc] init];
    //ctr_setting.view.backgroundColor = [UIColor yellowColor];
    [ctr_array addObject:ctr_setting];
    [ctr_setting release];
    
    [self setViewControllers:ctr_array];
    
    
    UITabBarItem *tab_news = [[UITabBarItem alloc] initWithTitle:@"新闻" image:nil selectedImage:nil];
    UITabBarItem *tab_user = [[UITabBarItem alloc] initWithTitle:@"用户" image:nil selectedImage:nil];
    UITabBarItem *tab_setting = [[UITabBarItem alloc] initWithTitle:@"设置" image:nil selectedImage:nil];

    ctr_news.tabBarItem = tab_news;
    ctr_user.tabBarItem = tab_user;
    ctr_setting.tabBarItem = tab_setting;
    
    [self setSelectedIndex:1];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [super viewDidAppear:animated];
//}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_ItemNews release];
    [_ItemUser release];
    [_ItemSetting release];
    [super dealloc];
}
@end
