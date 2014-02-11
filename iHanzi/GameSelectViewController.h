//
//  GameSelectViewController.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-28.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameSelectDelegate;

@interface GameSelectViewController : UIViewController<GameSelectDelegate,UITableViewDataSource,UITableViewDelegate>

@end
