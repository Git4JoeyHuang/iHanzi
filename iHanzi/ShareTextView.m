//
//  ShareTextView.m
//  iHanzi
//
//  Created by Zhongwei on 14-2-2.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "ShareTextView.h"

@implementation ShareTextView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);

    CGContextBeginPath(context);
    
    UIColor *color = [UIColor colorWithRed:0.722f green:0.910f blue:0.980f alpha:0.7f];
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    
    CGFloat baseOffset = 7.0f + self.font.descender;
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat boundsX = self.bounds.origin.x;
    CGFloat boundsWidth = self.bounds.size.width;
    
    // Only draw lines that are visible on the screen.
    // (As opposed to throughout the entire view's contents)
    NSInteger firstVisibleLine = MAX(1, (self.contentOffset.y / self.font.lineHeight));
    NSInteger lastVisibleLine = ceilf((self.contentOffset.y + self.bounds.size.height) / self.font.lineHeight);
    for (NSInteger line = firstVisibleLine; line <= lastVisibleLine; ++line)
    {
        CGFloat linePointY = (baseOffset + (self.font.lineHeight * line));
        // Rounding the point to the nearest pixel.
        // Greatly reduces drawing time.
        CGFloat roundedLinePointY = roundf(linePointY * screenScale) / screenScale;
        CGContextMoveToPoint(context, boundsX, roundedLinePointY);
        CGContextAddLineToPoint(context, boundsWidth, roundedLinePointY);
    }
    CGContextClosePath(context);
    CGContextStrokePath(context);
}


//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//}

@end
