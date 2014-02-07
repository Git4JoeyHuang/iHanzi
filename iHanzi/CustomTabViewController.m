//
//  CustomTabViewController.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-29.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "CustomTabViewController.h"

@interface CustomTabViewController ()

@end

@implementation CustomTabViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.tabBarController) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
//    if (self.tabBarController) {
//        [self.navigationController setNavigationBarHidden:NO animated:animated];
//    }
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
