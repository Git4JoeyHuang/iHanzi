//
//  SocialShareView.m
//  iHanzi
//
//  Created by Zhongwei on 14-2-2.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "SocialShareView.h"

@implementation SocialShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    [toolBar sizeToFit];
    
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    [toolBar setItems:[NSArray arrayWithObject:doneButton]];
    
    [self.textview setInputAccessoryView:toolBar];
    
    [toolBar release];
}

-(void)doneAction
{
    [self.textview resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)dealloc {
    [_textview release];
    [super dealloc];
}
@end
