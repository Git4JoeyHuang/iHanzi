//
//  GameSelectingButton.m
//  iHanzi
//
//  Created by Zhongwei Huang on 2/10/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import "GameSelectingButton.h"

@implementation GameSelectingButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _unclocked = NO;
        _score = [[NSArray alloc] init];
        _index = 0;
        
        self.userInteractionEnabled = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //draw bg
    
    UIImage *bg;
    if (self.unclocked) {
         bg = [UIImage imageNamed:@"btn_normal.png"];
    }else {
        bg = [UIImage imageNamed:@"unclock.png"];
    }
    
    [bg drawInRect:rect];
    
    
    //draw score
    for (int i=0; i<_score.count; ++i) {
        UIImage* star;
        if ([[self.score objectAtIndex:i] intValue]==1) {
            star = [UIImage imageNamed:@"btn_click_star_light.png"];
        }else{
            star = [UIImage imageNamed:@"btn_click_star.png"];
        }
        CGRect frame = CGRectMake(14+17*i, 43, star.size.width, star.size.height);
        [star drawInRect:frame];
    }
    
    //draw lock
    UIImage *lock = [UIImage imageNamed:@"clock.png"];
    if (!self.unclocked) {
        [lock drawInRect:CGRectMake(0, 0, lock.size.width, lock.size.height)];
    }
    
    //draw lable
    UILabel* label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d",_index+1];
    label.textColor = [UIColor whiteColor];

    [label drawTextInRect:CGRectMake(20, 20, 37, 20)];
    [label release];
//    
//    NSString* text = [NSString stringWithFormat:@"%d",_index];
//    [text drawInRect:CGRectMake(20, 20, 37, 20) withFont:[UIFont fontWithName:@"System" size:17]];
    
}


@end
