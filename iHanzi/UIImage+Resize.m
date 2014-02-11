//
//  UIImage+Resize.m
//  iHanzi
//
//  Created by Zhongwei Huang on 2/11/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (resize)
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
