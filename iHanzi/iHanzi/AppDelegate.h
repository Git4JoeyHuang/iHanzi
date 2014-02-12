//
//  AppDelegate.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-28.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *navigator;
@end
