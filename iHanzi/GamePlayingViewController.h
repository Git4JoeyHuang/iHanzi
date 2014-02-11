//
//  GamePlayingViewController.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@interface GamePlayingViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,CustomIOS7AlertViewDelegate>
@property (retain, nonatomic) IBOutlet UIView *ratingView;
@property (assign, nonatomic) NSUInteger idx;
@property (retain, nonatomic) IBOutlet UILabel *tipLabel;

@property (retain, nonatomic) IBOutlet UIView *resultView;
@property (retain, nonatomic) IBOutlet UILabel *resultLabel;
@property (retain, nonatomic) IBOutlet UIView *contentBg;

@property (retain, nonatomic) IBOutlet UIButton *submitBtn;
@property (retain, nonatomic) IBOutlet UITableView *questionView;
- (IBAction)makeChoice:(id)sender;
-(id)initWithBlockIndex:(NSUInteger)block;
- (IBAction)submit:(id)sender;

@end
