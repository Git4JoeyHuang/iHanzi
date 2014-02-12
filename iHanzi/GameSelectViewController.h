//
//  GameSelectViewController.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-28.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControl.h"
@protocol GameSelectDelegate;

@interface GameSelectViewController : UIViewController<GameSelectDelegate,UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet CustomPageControl *pageIndicator;

@end
