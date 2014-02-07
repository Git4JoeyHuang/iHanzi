//
//  CustomGameSelectCell.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameSelectDelegate <NSObject>

-(void)didSelected:(NSUInteger)tag AtRow:(NSUInteger)row;

@end

@interface CustomGameSelectCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (assign, nonatomic) NSUInteger rowIndex;


@property (assign, nonatomic) id<GameSelectDelegate> delegate;

+(id)loadFromNib;

- (IBAction)btnSelected:(id)sender;

@end
