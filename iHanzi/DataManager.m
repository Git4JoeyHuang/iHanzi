//
//  DataManager.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "DataManager.h"
#define TOTAL_NUM 500

@implementation Question


@end

static DataManager* instance=nil;
@implementation DataManager

+(id)sharedInstance
{
    @synchronized(instance)
    {
        if (!instance) {
            instance = [[DataManager alloc] init];
        }
        return instance;
    }
}

-(id)init
{
    if (self = [super init]) {
        answers = [[NSMutableArray alloc] initWithCapacity:TOTAL_NUM];
        questions = [[NSMutableArray alloc] initWithCapacity:TOTAL_NUM];
        
        for (int i=0; i<TOTAL_NUM; ++i) {
            [answers addObject:[NSNumber numberWithBool:NO]];
        }
        
        [self loadData];
    }
    return self;
}

-(void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TiKu" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSMutableArray* arr = [dict objectForKey:@"tArray"];
    for (int i=0; i<TOTAL_NUM; ++i) {
        int idx = rand()%[arr count];
        NSDictionary* d = (NSDictionary*)[arr objectAtIndex:idx];
        Question *q = [[Question alloc] init];
        [q setType:[[d objectForKey:@"type"] intValue]];
        [q setRight_answer:[[d objectForKey:@"right_answer"] intValue]];
        [q setAnswers:[NSArray arrayWithArray:[d objectForKey:@"answers"]]];
        [q setDescription:[d objectForKey:@"description"]];
        [questions addObject:q];
        //[arr removeObjectAtIndex:idx];
    }
}

-(void)answerQuestion:(NSUInteger)qIdx Right:(BOOL)right
{
    if (qIdx<500) {
        [answers replaceObjectAtIndex:qIdx withObject:[NSNumber numberWithBool:right]];
    }
}

-(BOOL)getAnswerAtIndex:(NSUInteger)qIdx
{
    return [[answers objectAtIndex:qIdx] boolValue];
}

-(Question*)getQuestionAtIndex:(NSUInteger)qIdx
{
    return [questions objectAtIndex:qIdx];
}

-(void)dealloc
{
    [answers release];
    [super dealloc];
    
}
@end
