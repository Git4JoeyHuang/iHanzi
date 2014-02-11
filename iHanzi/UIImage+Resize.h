//
//  UIImage+Resize.h
//  iHanzi
//
//  Created by Zhongwei Huang on 2/11/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UIImage (resize)
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end

