//
//  DataManager.h
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

enum Question_Type {
    WORD = 1,
    PHRASE = 2,
    PINYING = 3,
    SENTENCE = 4
    };

@interface Question : NSObject

@property (nonatomic, assign) int type;
@property (nonatomic, assign) int right_answer;
@property (nonatomic, retain) NSArray* answers;
@property (nonatomic, copy) NSString* description;
@end

@interface DataManager : NSObject
{
    NSMutableArray *answers;
    NSMutableArray *questions;
}
@property (assign, nonatomic) int stars;
@property (assign, nonatomic) int quesIdx;
@property (assign, nonatomic) int blockIdx;
+(id)sharedInstance;
-(void)loadData;
-(void)answerQuestion:(NSUInteger)qIdx Right:(BOOL)right;
-(BOOL)getAnswerAtIndex:(NSUInteger)qIdx;
-(Question*)getQuestionAtIndex:(NSUInteger)qIdx;
-(void)answerRight;
@end
