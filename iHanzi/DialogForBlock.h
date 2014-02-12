//
//  DialogForBlock.h
//  iHanzi
//
//  Created by Zhongwei Huang on 2/12/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialogForBlock : UIView

@property (assign, nonatomic) int stars;
@property (retain, nonatomic) NSArray* score;

@property (retain, nonatomic) IBOutlet UILabel *contentLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIView *starView;
@property (retain, nonatomic) IBOutlet UIView *container;

-(void)updateWithScore:(NSArray*)score;
-(id)loadFromNib;

@end
