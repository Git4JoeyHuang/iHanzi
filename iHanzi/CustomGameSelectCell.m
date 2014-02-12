//
//  CustomGameSelectCell.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "CustomGameSelectCell.h"
#import "DataManager.h"
#define total_blocks 60

@implementation CustomGameSelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

+ (id)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CustomGameSelectCell" owner:nil options:nil] lastObject];
}

- (void)btnSelected:(UIGestureRecognizer*)tap {
    GameSelectingButton *btn = (GameSelectingButton*)tap.view;
    
    if (!btn.unclocked) {
        return;
    }
    
    if (_delegate) {
        [_delegate didSelected:btn.tag AtRow:self.rowIndex InTableView:self.tableviewIndex];
    }
}


-(void)setRowIndex:(NSUInteger)rowIndex
{
    _rowIndex = rowIndex;
//    [self.btn1 setTitle:[NSString stringWithFormat:@"第%d关",3*rowIndex+1] forState:UIControlStateNormal];
//    [self.btn2 setTitle:[NSString stringWithFormat:@"第%d关",3*rowIndex+2] forState:UIControlStateNormal];
//    [self.btn3 setTitle:[NSString stringWithFormat:@"第%d关",3*rowIndex+3] forState:UIControlStateNormal];
//    self.btn1 = [[[NSBundle mainBundle] loadNibNamed:@"GameSelectingButton" owner:nil options:nil] lastObject];
    //GameSelectingButton *btn1 = [[GameSelectingButton alloc] initWithFrame:CGRectMake(31, 11, 77, 77)];
    
    //for each btn
    for (UIView* view in self.contentView.subviews) {
        GameSelectingButton* btn = (GameSelectingButton*)view;
        int tag = btn.tag;
        int blockIdx = 3*rowIndex + tag;
        
        if (blockIdx<total_blocks) {
            btn.index = blockIdx;
            if (blockIdx<=[[DataManager sharedInstance] unlockIdx]) {
                btn.unclocked = YES;
            }
            
            btn.score = [NSArray arrayWithObjects:
                         [NSNumber numberWithInt:[[DataManager sharedInstance] getAnswerAtIndex:3*blockIdx]],
                         [NSNumber numberWithInt:[[DataManager sharedInstance] getAnswerAtIndex:3*blockIdx+1]],
                         [NSNumber numberWithInt:[[DataManager sharedInstance] getAnswerAtIndex:3*blockIdx+2]],
                         nil];
            
            [btn addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnSelected:)] autorelease] ];
            
            [btn setNeedsDisplay];
        }

    }
    
    /*
    _btn1.score = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1],[NSNumber numberWithInt:0],nil];
    _btn1.index = 3*rowIndex+1;
    [_btn1 addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnSelected:)] autorelease] ];
    //self.btn1 = btn1;
    [self.btn1 setNeedsDisplay];
    
    //GameSelectingButton *btn2 = [[GameSelectingButton alloc] initWithFrame:CGRectMake(122, 11, 77, 77)];
    //self.btn2 = btn2;
    _btn2.unclocked = YES;
    _btn2.score = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1],[NSNumber numberWithInt:0],nil];
    _btn2.index = 3*rowIndex+2;
        [_btn2 addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnSelected:)] autorelease] ];
    [self.btn2 setNeedsDisplay];
    //[btn2 release];
    
    //GameSelectingButton *btn3 = [[GameSelectingButton alloc] initWithFrame:CGRectMake(215, 11, 77, 77)];
    //self.btn3 = btn3;
    _btn3.unclocked = YES;
    _btn3.score = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1],[NSNumber numberWithInt:0],nil];
    _btn3.index = 3*rowIndex+3;
        [_btn3 addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnSelected:)] autorelease] ];
    [self.btn3 setNeedsDisplay];
    //[btn3 release];
     */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_btn1 release];
    [_btn2 release];
    [_btn3 release];
    [super dealloc];
}
@end
