//
//  DialogForBlock.m
//  iHanzi
//
//  Created by Zhongwei Huang on 2/12/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import "DialogForBlock.h"

@implementation DialogForBlock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
-(id)initWithScores:(NSArray *)arr Stars:(int)star_num
{
    self = [super init];
    if (self) {
        [self setScore: [NSArray arrayWithArray:arr]];
        self.stars = star_num;
        UIView* view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        [self setFrame:view.frame];
        [self addSubview:view];
    }
    return self;
}
 */

-(id)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];

    if (self.contentLabel) {
        [self.contentLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"result_content.png"]]];
    }
    
}

-(void)updateWithScore:(NSArray*)score
{
    int num = 0;
    
    for (int i=0; i<score.count; ++i) {
        UIImageView* image = (UIImageView*)[self.starView viewWithTag:i+1];
        if ([[score objectAtIndex:i] intValue]==1) {
            num++;
            [image setImage:[UIImage imageNamed:@"btn_click_star_light.png"]];
        }else{
            [image setImage:[UIImage imageNamed:@"btn_click_star.png"]];
        }
    }
    
    [self.titleLabel setText:[NSString stringWithFormat:@"共答对%d题",num]];
}


- (void)dealloc {
    [_contentLabel release];
    [_titleLabel release];
    [_starView release];
    [_container release];
    [super dealloc];
}
@end
