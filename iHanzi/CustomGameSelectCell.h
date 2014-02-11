//
//  CustomGameSelectCell.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSelectingButton.h"

@protocol GameSelectDelegate <NSObject>

-(void)didSelected:(NSUInteger)tag AtRow:(NSUInteger)row;
-(void)didSelected:(NSUInteger)tag AtRow:(NSUInteger)row InTableView:(NSUInteger)table;

@end

@interface CustomGameSelectCell : UITableViewCell

//@property (retain, nonatomic) IBOutlet UIButton *btn1;
//@property (retain, nonatomic) IBOutlet UIButton *btn2;
//@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (assign, nonatomic) NSUInteger rowIndex;
@property (assign, nonatomic) NSUInteger tableviewIndex;

@property (retain, nonatomic) IBOutlet GameSelectingButton *btn1;
@property (retain, nonatomic) IBOutlet GameSelectingButton *btn2;
@property (retain, nonatomic) IBOutlet GameSelectingButton *btn3;


@property (assign, nonatomic) id<GameSelectDelegate> delegate;

+(id)loadFromNib;

- (IBAction)btnSelected:(id)sender;

@end
