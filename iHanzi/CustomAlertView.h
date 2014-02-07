//
//  CustomAlertView.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate <NSObject>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface CustomAlertView : UIAlertView
{
    NSMutableArray *buttonArray;
}

@property (retain, nonatomic) UIImage *backgroundImage;
@property (retain, nonatomic) UIImage *contentImage;

@property (assign, nonatomic) id<CustomAlertViewDelegate> cavDelegate;


-(id)initWithBackgroundImage:(UIImage*)bg ContentImage:(UIImage*)cg;
-(void)addButton:(UIButton*)button;

@end
