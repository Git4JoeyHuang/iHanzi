//
//  CustomPageControl.m
//  iHanzi
//
//  Created by Zhongwei Huang on 2/12/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import "CustomPageControl.h"

@implementation CustomPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        _imageNormal = [[UIImage imageNamed:@"all_leve_unseled.png"] retain];
//        _imageHighlighted = [[UIImage imageNamed:@"all_leve_seled.png"] retain];
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

-(void)updateDots
{
    if (self.imageNormal && self.imageHighlighted) {
        NSArray *subviews = self.subviews;
        for (int i=0; i<subviews.count; ++i) {
            UIView* view = [subviews objectAtIndex:i];
            UIImage* image = i==self.currentPage ? _imageHighlighted : _imageNormal;
            if ([view isKindOfClass:[UIImageView class]]) {
                [((UIImageView*)view) setImage:image];
            }
        }
    }
}

-(void)setImageNormal:(UIImage*)image
{
    if (_imageNormal) {
        [_imageNormal release];
    }
    _imageNormal = [image retain];
    [self updateDots];
}


-(void)setImageHighlighted:(UIImage *)imageHighlighted
{
    if (_imageHighlighted) {
        [_imageHighlighted release];
    }
    _imageHighlighted = [imageHighlighted retain];
    [self updateDots];
}
//
//- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { // 点击事件
//    [super endTrackingWithTouch:touch withEvent:event];
//    [self updateDots];
//}

-(void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}

-(void)dealloc
{

    if (_imageNormal) {
        [_imageNormal release];
    }
    
    
    if (_imageHighlighted) {
        [_imageHighlighted release];
    }
    
    
    [super dealloc];
}
@end
