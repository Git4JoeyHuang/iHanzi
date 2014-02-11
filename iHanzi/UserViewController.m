//
//  UserViewController.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-28.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "UserViewController.h"
#import "GameSelectViewController.h"
#import "SocialShareView.h"

@interface UserViewController ()

@end

@implementation UserViewController

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
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setFrame:CGRectMake(0, 0, 80, 40)];
//    [btn setTitle:@"Start" forState:UIControlStateNormal];
//    btn.center = self.view.center;
//    
//    [self.view addSubview:btn];
//    [btn release];
//    
//    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //init news displayview
    [self initNewsDisplay];
    
    [self.view bringSubviewToFront:self.pageControl];
}

-(void)initNewsDisplay
{
    int newsCount = 3;
    CGRect frame = self.newsDisplayView.bounds;
    for (int i=0; i<newsCount; ++i) {
        CGRect rect = CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height);
        UIView* view = [[UIView alloc] initWithFrame:rect];
        [view setBackgroundColor:[UIColor lightGrayColor]];
        /*add image;
        ......to be continued
         */
        
        //add label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, frame.size.width, 20)];
        titleLabel.text = @"倒计时";
        [view addSubview:titleLabel];
        
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 62, frame.size.width,20)];
        subtitleLabel.text = @"小伙伴加油！";
        [view addSubview:subtitleLabel];
        
        [self.newsDisplayView addSubview:view];
        [titleLabel release];
        [subtitleLabel release];
        [view release];
    }
    
    CGSize contentSize = CGSizeMake(frame.size.width*newsCount, frame.size.height);
    [self.newsDisplayView setContentSize:contentSize];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
  
-(void)btnClicked:(id)sender
{
    GameSelectViewController *controller = [[GameSelectViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_newsDisplayView release];
    [_pageControl release];
    [super dealloc];
}
- (IBAction)startGame:(id)sender {
    GameSelectViewController *controller = [[GameSelectViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (IBAction)shareMessage:(id)sender {
    SocialShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"SocialShareView" owner:self options:nil] lastObject];
    CGRect rect = shareView.bounds;
   
    [shareView setFrame:shareView.bounds];
    [self.view addSubview:shareView];
    [shareView setCenter:self.view.center];
}
@end
