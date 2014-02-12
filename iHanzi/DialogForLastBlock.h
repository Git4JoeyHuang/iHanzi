//
//  DialogForLastBlock.h
//  iHanzi
//
//  Created by Zhongwei Huang on 2/12/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialogForLastBlock : UIView
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;

-(id)loadFromNib;
-(void)updateWithScore:(int)score;
@end
