//
//  GamePlayingViewController.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "GamePlayingViewController.h"
#import "DataManager.h"

#define SUBMIT_TAG 1000
#define NEXT_TAG 2000

@interface GamePlayingViewController ()
{
    int step;
    int stars;
    int selectRow;
    Question* question;
}
@end

@implementation GamePlayingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRowIndex:(NSUInteger)row
{
    self = [self initWithNibName:@"GamePlayingViewController" bundle:nil];
    if (self) {
        self.idx = row;
    }
    return self;
}

- (IBAction)submit:(id)sender {
//    UIButton *btn = (UIButton*)sender;
//    if (btn.tag == SUBMIT_TAG) {
//        [self.resultView setHidden:NO];
//        [self.resultLabel setText:@"恭喜你，答对了！"];
//        btn.tag = NEXT_TAG;
//        [btn setTitle:@"下一题" forState:UIControlStateNormal];
//    }else {
//        [self.resultView setHidden:YES];
//        btn.tag = SUBMIT_TAG;
//        [btn setTitle:@"确定" forState:UIControlStateNormal];
//    }
    BOOL correct = (selectRow == question.right_answer);
    step = (step+1)%6;
    
    NSString *message;
    NSString *title;
    
    if (correct) {
        title = @"答对了";
        stars++;
        message = [NSString stringWithFormat:@"恭喜你，答对了，获得一颗星星"];
        [[self.ratingView viewWithTag:step] setAlpha:1.0];
        if (step==5) {
            message = [NSString stringWithFormat:@"本关共获得%d颗星星，继续努力",stars];
            //[[self.ratingView viewWithTag:5] setAlpha:1.0];
        }
        int qIdx = [[DataManager sharedInstance] blockIdx]*5+step-1;
        [[DataManager sharedInstance] answerQuestion:qIdx Right:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        title = @"答错了";
        message = [NSString stringWithFormat:@"很遗憾，差一点就答对了"];
        if (step==5) {
            message = [NSString stringWithFormat:@"本关共获得%d颗星星，继续努力",stars];
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = [NSString stringWithFormat:@"第%d关",[[DataManager sharedInstance] blockIdx]];
    
    selectRow = -1;
    [self updateQuestion];
}

-(void)update
{
    int cur_question = [[DataManager sharedInstance] blockIdx]*5+[[DataManager sharedInstance] quesIdx];
    for (int i=1; i<=5; ++i) {
        if ([[DataManager sharedInstance]getAnswerAtIndex:cur_question++]) {
            [[_ratingView viewWithTag:i] setAlpha:1.0];
        }else{
            [[_ratingView viewWithTag:i] setAlpha:0.5];
        }
    }
    
}

-(void)updateQuestion
{
    int qIdx = [[DataManager sharedInstance] blockIdx]*5 + step;
    question = [[DataManager sharedInstance] getQuestionAtIndex:qIdx];
    
    switch (question.type) {
        case 0:
            self.tipLabel.text = @"选择正确的拼音";
            break;
            
        default:
            self.tipLabel.text = @"选择正确的拼音";
            break;
    }
    
    [self.submitBtn setEnabled:NO];
    
}

-(void)setStars
{
    int num_to_show = [[DataManager sharedInstance] stars] % 6;
    int start_tag = 1;
    for (int i=0; i<num_to_show; ++i) {
        [[_ratingView viewWithTag:start_tag+i] setAlpha:1.0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)makeChoice:(id)sender {
    UIButton *button = (UIButton*)sender;
    

    if (button.tag == 1) {
        //answer right
        int cur_question = [[DataManager sharedInstance] blockIdx]*5+[[DataManager sharedInstance] quesIdx];
        [[DataManager sharedInstance] answerQuestion:cur_question Right:YES];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"答对了" message:@"祝贺你，又得了一颗小星星" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
//        
//        [alert show];
        
    }else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"答错了" message:@"很遗憾，差一点就对了，继续努力" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
//        [alert show];
    }
    
    
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (step == 5) {
        int bIdx = [[DataManager sharedInstance] blockIdx];
        [[DataManager sharedInstance] setBlockIdx:bIdx+1];
        [[DataManager sharedInstance] setQuesIdx:0];
        
        step = 0;
        stars = 0;
        //clear rating view
        for (UIView* view in [self.ratingView subviews]) {
            [view setAlpha:0.5];
        }
        
        //set title
        [self setTitle:[NSString stringWithFormat:@"第%d关",bIdx+1]];
    }
    selectRow = -1;
    [self updateQuestion];
    [self.questionView reloadData];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (question) {
        return [[question answers] count];
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell.imageView setImage:[UIImage imageNamed:@"letter_a.png"]];
            [cell.textLabel setText:[[question answers]objectAtIndex:0] ];
            break;
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell.imageView setImage:[UIImage imageNamed:@"letter_b.png"]];
            [cell.textLabel setText:[[question answers]objectAtIndex:1]];
            break;
        case 2:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell.imageView setImage:[UIImage imageNamed:@"letter_c.png"]];
            [cell.textLabel setText:[[question answers]objectAtIndex:2]];
            break;
        case 3:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell.imageView setImage:[UIImage imageNamed:@"letter_d.png"]];
            [cell.textLabel setText:[[question answers]objectAtIndex:3]];
            break;
        default:
            break;
    }

    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"This is the question description This is the question description This is the question description This is the question description This is the question description";
//}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!question || question.description.length==0) {
        return nil;
    }
    NSString *text = question.description;//[self tableView:tableView titleForHeaderInSection:0];
    CGSize constrainSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0] constrainedToSize:CGSizeMake(tableView.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, constrainSize.width, constrainSize.height+10)];
    [textView setText:text];
    textView.lineBreakMode = NSLineBreakByWordWrapping;
    textView.numberOfLines = 0;
    [textView sizeToFit];
    return [textView autorelease];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!question || question.description.length==0) {
        CGRect frame = tableView.frame;
        tableView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,44*question.answers.count);
        return 0.0;
    }
    NSString *text = question.description;//[self tableView:tableView titleForHeaderInSection:0];
    CGSize constrainSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0] constrainedToSize:CGSizeMake(tableView.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = tableView.frame;
    tableView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, constrainSize.height+10+44*question.answers.count);
    
    return constrainSize.height+10;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i=0; i<[self tableView:tableView numberOfRowsInSection:0]; ++i) {
        if (i!=indexPath.row) {
            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    if (![self.submitBtn isEnabled]) {
        [self.submitBtn setEnabled:YES];
    }
    
    selectRow = indexPath.row;
    
}


- (void)dealloc {
    [_ratingView release];
    [_resultView release];
    [_resultLabel release];
    [_questionView release];
    [_submitBtn release];
    [_tipLabel release];
    [super dealloc];
}

#pragma mark 
@end
