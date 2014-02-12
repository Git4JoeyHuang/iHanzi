//
//  DialogForLastBlock.m
//  iHanzi
//
//  Created by Zhongwei Huang on 2/12/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import "DialogForLastBlock.h"

@implementation DialogForLastBlock

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

-(id)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

-(void)updateWithScore:(int)score
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%d/180",score];
    self.titleLabel.text = [NSString stringWithFormat:@"共答对%d题",score];
}

- (void)dealloc {
    [_titleLabel release];
    [_scoreLabel release];
    [super dealloc];
}
@end
