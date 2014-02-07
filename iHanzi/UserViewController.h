//
//  UserViewController.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-28.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabViewController.h"

@interface UserViewController : CustomTabViewController<UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property (retain, nonatomic) IBOutlet UIScrollView *newsDisplayView;
- (IBAction)startGame:(id)sender;
- (IBAction)shareMessage:(id)sender;

@end
