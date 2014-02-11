//
//  CustomAlertView.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(id)initWithBackgroundImage:(UIImage *)bg ContentImage:(UIImage *)cg
{
    if (self = [super init]) {
        self.backgroundImage = bg;
        self.contentImage = cg;
        
        buttonArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addButton:(UIButton *)button
{
    [buttonArray addObject:button];
}

- (void) show {
    [super show];
    CGSize imageSize = self.backgroundImage.size;
    self.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
}

- (void)drawRect:(CGRect)rect {
    
    CGSize imageSize = self.backgroundImage.size;
    [self.backgroundImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    
}

-(void) buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    
    if (_cavDelegate) {
        if ([_cavDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
        {
            [_cavDelegate alertView:self clickedButtonAtIndex:btn.tag];
        }
    }
    
    [self dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)layoutSubviews
{
    //屏蔽系统的ImageView 和 UIButton
    for (UIView *v in [self subviews]) {
        if ([v class] == [UIImageView class]){
            [v setHidden:YES];
        }
        
        if ([v class] == [UIButton class]) {
            [v setHidden:YES];
        }
    }
    
    for (int i=0;i<[buttonArray count]; i++) {
        UIButton *btn = [buttonArray objectAtIndex:i];
        btn.tag = i;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }

    if (_contentImage) {
        UIImageView *contentview = [[UIImageView alloc] initWithImage:self.contentImage];
        contentview.frame = CGRectMake(0, 0, contentview.frame.size.width, contentview.frame.size.height);
        contentview.center = self.center;
        [self addSubview:contentview];
    }
}


-(void)dealloc
{
    [buttonArray release];
    [_backgroundImage release];
    if (_contentImage) {
        [_contentImage release];
        _contentImage = nil;
    }
    [super dealloc];
}
@end
