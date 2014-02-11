//
//  GameSelectingButton.h
//  iHanzi
//
//  Created by Zhongwei Huang on 2/10/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSelectingButton : UIView
@property (nonatomic, assign) BOOL unclocked;
@property (nonatomic, retain) NSArray* score;
@property (nonatomic, assign) int index;
@end
