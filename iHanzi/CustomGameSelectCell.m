//
//  CustomGameSelectCell.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "CustomGameSelectCell.h"

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

- (IBAction)btnSelected:(id)sender {
    UIButton *btn = (UIButton*)sender;

    if (_delegate) {
        [_delegate didSelected:btn.tag AtRow:self.rowIndex];
    }
}


-(void)setRowIndex:(NSUInteger)rowIndex
{
    _rowIndex = rowIndex;
    [self.btn1 setTitle:[NSString stringWithFormat:@"第%d关",3*rowIndex+1] forState:UIControlStateNormal];
    [self.btn2 setTitle:[NSString stringWithFormat:@"第%d关",3*rowIndex+2] forState:UIControlStateNormal];
    [self.btn3 setTitle:[NSString stringWithFormat:@"第%d关",3*rowIndex+3] forState:UIControlStateNormal];
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
