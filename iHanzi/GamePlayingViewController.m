//
//  GamePlayingViewController.m
//  iHanzi
//
//  Created by Zhongwei on 14-1-30.
//  Copyright (c) 2014年 Zhongwei. All rights reserved.
//

#import "GamePlayingViewController.h"
#import "DataManager.h"
#import "UIImage+Resize.h"
#import "RollingViewController.h"
#import "CustomAlertView.h"
#import "DialogForBlock.h"
#import "DialogForLastBlock.h"
#import "AWActionSheet.h"
#import "WXApi.h"
//#import "CustomIOS7AlertView.h"



#define SUBMIT_TAG 1000
#define NEXT_TAG 2000

#define questions_per_block 3
#define last_block 1

@interface GamePlayingViewController ()<UIActionSheetDelegate,AWActionSheetDelegate>
{
    int step;
    int stars;
    int selectRow;
    NSMutableArray* score;
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

- (id)initWithBlockIndex:(NSUInteger)block
{
    self = [self initWithNibName:@"GamePlayingViewController" bundle:nil];
    if (self) {
        self.idx = block;
        score = [[NSMutableArray alloc] initWithCapacity:questions_per_block];
    }
    return self;
}

- (IBAction)submit:(id)sender {
    UIButton *btn = (UIButton*)sender;
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
//    BOOL correct = (selectRow == question.right_answer);
//    ++step;
//    
//    NSString *message;
//    NSString *title;
//    
//    if (correct) {
//        title = @"答对了";
//        stars++;
//        message = [NSString stringWithFormat:@"恭喜你，答对了，获得一颗星星"];
//        [[self.ratingView viewWithTag:step] setAlpha:1.0];
//        if (step==questions_per_block) {
//            message = [NSString stringWithFormat:@"本关共获得%d颗星星，继续努力",stars];
//            //[[self.ratingView viewWithTag:5] setAlpha:1.0];
//        }
//        int qIdx = [[DataManager sharedInstance] blockIdx]*questions_per_block+step-1;
//        //[[DataManager sharedInstance] answerQuestion:qIdx Right:YES];
//        [[DataManager sharedInstance] answerQuestion:qIdx Result:1];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
//        [alert show];
//    }else{
//        title = @"答错了";
//        message = [NSString stringWithFormat:@"很遗憾，差一点就答对了"];
//        if (step==questions_per_block) {
//            message = [NSString stringWithFormat:@"本关共获得%d颗星星，继续努力",stars];
//        }
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
//        [alert show];
//    }
    
    ++step;
    if (step==questions_per_block) {
        
        //最后一关
        if (self.idx == last_block) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜您" message:@"您已经答完全部关卡，真厉害！" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:@"去抽奖", nil];
//            [alert show];
            CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
            
            // Add some custom content to the alert view
            DialogForLastBlock *dialog = [[DialogForLastBlock alloc] loadFromNib];
            [dialog updateWithScore:[[DataManager sharedInstance] stars]];
            
            [alertView setContainerView:dialog];
            
            // Modify the parameters
            //[alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"继续", nil]];
            [alertView setDelegate:self];
//
//            // You may use a Block, rather than a delegate.
            [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
                NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
                [alertView close];
            }];
            
            [alertView setUseMotionEffects:true];
            
            // And launch the dialog
            [alertView show];
        }else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本关答完" message:[NSString stringWithFormat:@"获得%d颗星星",stars] delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
//            [alert show];

            CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
            
            // Add some custom content to the alert view
            DialogForBlock *dialog = [[DialogForBlock alloc] loadFromNib ];
            [dialog updateWithScore:score];
//            dialog.container = [[[NSBundle mainBundle] loadNibNamed:@"DialogForBlock" owner:dialog options:nil] objectAtIndex:0];
            
            //[alertView setContainerView:[self createLocalFinishAlert]];
            [alertView setContainerView:dialog];
            // Modify the parameters
            //[alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"继续", nil]];
            [alertView setDelegate:self];
            
            // You may use a Block, rather than a delegate.
            [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
                NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
                [alertView close];
            }];
            
            [alertView setUseMotionEffects:true];
            
            // And launch the dialog
            [alertView show];
        }
    }else{
        [self updateQuestion];
    }
    
    
    
}

-(UIView*)createLocalFinishAlert
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 240)] ;
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content.png"]];
    [bg setFrame:CGRectMake(0, 0, 260, 225)];
    [view addSubview:bg];
    [bg release];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"result.png"]];
    [logo setFrame:CGRectMake(0, 0, logo.bounds.size.width, logo.bounds.size.height)];
    [logo setCenter:CGPointMake(view.bounds.size.width/2, logo.bounds.size.height/2+5)];
    [view addSubview:logo];
    [logo release];
     
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 0;
    //[button setTitle:@"继续" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"nest_normal.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 70, 30)];
    [button setCenter:CGPointMake(view.bounds.size.width/2, view.bounds.size.height-15)];
    [view addSubview:button];
    
    return [view autorelease];
}

-(UIView*)creatGlobalFinishAlert
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 240)] ;
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content.png"]];
    [bg setFrame:CGRectMake(0, 0, 260, 225)];
    [view addSubview:bg];
    [bg release];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"result.png"]];
    [logo setFrame:CGRectMake(0, 0, logo.bounds.size.width, logo.bounds.size.height)];
    [logo setCenter:CGPointMake(view.bounds.size.width/2, logo.bounds.size.height/2+5)];
    [view addSubview:logo];
    [logo release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 0;
    //[button setTitle:@"继续" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"nest_normal.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 70, 30)];
    [button setCenter:CGPointMake(view.bounds.size.width/2-40, view.bounds.size.height-15)];
    [view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.tag = 1;
    [button2 setBackgroundImage:[UIImage imageNamed:@"get_gift.png"] forState:UIControlStateNormal];
    [button2 setFrame:CGRectMake(0, 0, 70, 30)];
    [button2 setCenter:CGPointMake(view.bounds.size.width/2+40, view.bounds.size.height-15)];
    [view addSubview:button2];
    
    return [view autorelease];
}


//-(void)alertBtnClicked:(id)sender
//{
//    UIButton *button = (UIButton*)sender;
//    int buttonIndex = button.tag;
//    if (buttonIndex==0) {
//        if (self.idx<last_block && self.idx>=[[DataManager sharedInstance] unlockIdx])
//        {
//            [[DataManager sharedInstance] setUnlockIdx:self.idx+1];
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//    }else if(buttonIndex==1){
//        //进入抽奖页面
//        RollingViewController *rollingController = [[RollingViewController alloc] init];
//        [self.navigationController pushViewController:rollingController animated:YES];
//        [rollingController release];
//    }else {
//        //进入分享页面
//        [self showAWSheet];
//    }
//}

- (void)showAWSheet
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet showInView:self.view];
    [sheet release];
}

- (void) sendImageContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"logo.png"]];
    message.title = @"我在玩有趣的汉字闯关游戏";
    message.description = @"【我爱汉字美】是上海教育电视台为推广汉字文化而制作的App游戏。3月22日起，每周六、日20：25分播出同名语言类大型季播节目。";
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
    
    message.mediaObject = ext;
 
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

#pragma mark AWActionSheetDelegate
-(int)numberOfItemsInActionSheet
{
    return 3;
    
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    switch (index) {
            
        default:
            if ([WXApi isWXAppInstalled]) {
                [self sendImageContent];
            }
            break;
    }
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    
    switch (index) {
        case 0:
            [cell.iconView setImage:[UIImage imageNamed:@"sina.png"] ];
            break;
        case 1:
            [cell.iconView setImage:[UIImage imageNamed:@"qq.png"] ];
            break;
        case 2:
            [cell.iconView setImage:[UIImage imageNamed:@"wexin.png"] ];
            break;
        case 3:
            [cell.iconView setImage:[UIImage imageNamed:@"friend.png"] ];
            break;
        default:
            break;
    }
//    [[cell iconView] setBackgroundColor:
//     [UIColor colorWithRed:rand()%255/255.0f
//                     green:rand()%255/255.0f
//                      blue:rand()%255/255.0f
//                     alpha:1]];
//    [[cell titleLabel] setText:[NSString stringWithFormat:@"item %d",index]];
    cell.index = index;
    return cell;
}

-(void)shareBtnClicked:(id)sender
{
    if ([WXApi isWXAppInstalled]) {
        [self sendImageContent];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = [NSString stringWithFormat:@"第%d关",[[DataManager sharedInstance] blockIdx]+1];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = CGRectMake(0.0, 0.0, 26.0, 23.0);
    
    [backButton setImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    
    [backButton setImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateSelected];
    
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    [temporaryBarButtonItem release];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    shareButton.frame = CGRectMake(0.0, 0.0, 26.0, 23.0);
    
    [shareButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    [shareButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateSelected];
    
    [shareButton addTarget:self action:@selector(showAWSheet) forControlEvents:UIControlEventTouchUpInside];
       
    temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    
    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
    
    [temporaryBarButtonItem release];
    
    //set Background image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.jpg"]];
    
//    CGRect frame = self.questionView.bounds;
//    UIImageView *contentBg = [[UIImageView alloc] initWithFrame:frame ];
//    [contentBg setImage:[UIImage imageNamed:@"result_content.png"] ];
    
    self.contentBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithImage:[UIImage imageNamed:@"result_content.png"] scaledToSize:self.contentBg.frame.size  ]];
    self.resultLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_title.png"]];
    
    self.questionView.backgroundView = nil;
    self.questionView.backgroundColor = [UIColor clearColor];
    //[contentBg release];
    
    [self.submitBtn setEnabled:NO];
    [self.resultLabel setHidden:YES];
    
    //selectRow = -1;
    [self updateQuestion];
    
    [self updateScore];
    
    step = 0;
    stars = 0;
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)update
{
    int cur_question = [[DataManager sharedInstance] blockIdx]*questions_per_block+[[DataManager sharedInstance] quesIdx];
    for (int i=1; i<=questions_per_block; ++i) {
        if ([[DataManager sharedInstance]getAnswerAtIndex:cur_question++]) {
            [[_ratingView viewWithTag:i] setAlpha:1.0];
        }else{
            [[_ratingView viewWithTag:i] setAlpha:0.5];
        }
    }
    
}

-(void)updateScore
{
    for (UIImageView *view in _ratingView.subviews) {
        int tag = view.tag;
        switch ([[DataManager sharedInstance] getAnswerAtIndex:questions_per_block*self.idx+tag]) {
            case 0:
                 [view setImage:[UIImage imageNamed:@"fail.png"]];
                break;
            case 1:
                 [view setImage:[UIImage imageNamed:@"ok.png"]];
                break;
            case 2:
                 [view setImage:[UIImage imageNamed:@"error.png"]];
                break;
            default:
                break;
        }
    }
}

-(void)updateQuestion
{
    int qIdx = [[DataManager sharedInstance] blockIdx]*questions_per_block + step;
    question = [[DataManager sharedInstance] getQuestionAtIndex:qIdx];
    
//    switch (question.type) {
//        case 0:
//            self.tipLabel.text = @"选择正确的拼音";
//            break;
//            
//        default:
//            self.tipLabel.text = @"选择正确的拼音";
//            break;
//    }
    [self.questionView reloadData];
    [self.questionView setUserInteractionEnabled:YES];
    
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
        int cur_question = [[DataManager sharedInstance] blockIdx]*questions_per_block+[[DataManager sharedInstance] quesIdx];
        //[[DataManager sharedInstance] answerQuestion:cur_question Right:YES];
        [[DataManager sharedInstance] answerQuestion:cur_question Result:1];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"答对了" message:@"祝贺你，又得了一颗小星星" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
//        
//        [alert show];
        
    }else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"答错了" message:@"很遗憾，差一点就对了，继续努力" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil, nil];
//        [alert show];
    }
    
    
}

#pragma mark UIAlertViewDelegate
/*
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (step == questions_per_block) {
//        int bIdx = [[DataManager sharedInstance] blockIdx];
//        [[DataManager sharedInstance] setBlockIdx:bIdx+1];
//        [[DataManager sharedInstance] setQuesIdx:0];
//        
//        step = 0;
//        stars = 0;
//        //clear rating view
//        for (UIView* view in [self.ratingView subviews]) {
//            [view setAlpha:0.5];
//        }
//        
//        //set title
//        [self setTitle:[NSString stringWithFormat:@"第%d关",bIdx+1]];
//    }
//    selectRow = -1;
//    [self updateQuestion];
//    [self.questionView reloadData];
    //通关最后一关
    
    if (buttonIndex==0) {
        if (self.idx<last_block && self.idx>=[[DataManager sharedInstance] unlockIdx])
        {
            [[DataManager sharedInstance] setUnlockIdx:self.idx+1];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else if(buttonIndex == 1){
        //进入抽奖页面
        RollingViewController *rollingController = [[RollingViewController alloc] init];
        [self.navigationController pushViewController:rollingController animated:YES];
        [rollingController release];
    }else {
        [self showAWSheet];
    }
    
    
}
 */

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

    cell.backgroundView = nil;
    cell.backgroundColor = [UIColor clearColor];
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
//    if (!question || question.description.length==0) {
//        return nil;
//    }
//    NSString *text = question.description;//[self tableView:tableView titleForHeaderInSection:0];
//    CGSize constrainSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0] constrainedToSize:CGSizeMake(tableView.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, constrainSize.width, constrainSize.height+10)];
//    [textView setText:text];
//    textView.lineBreakMode = NSLineBreakByWordWrapping;
//    textView.numberOfLines = 0;
//    [textView sizeToFit];
//    return [textView autorelease];
    
    NSString *text = [NSString stringWithFormat:@"请选择正确的词语\n%@", question.description];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 90)];
    label.numberOfLines = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (!question || question.description.length==0) {
//        CGRect frame = tableView.frame;
//        tableView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,44*question.answers.count);
//        return 0.0;
//    }
//    NSString *text = question.description;//[self tableView:tableView titleForHeaderInSection:0];
//    CGSize constrainSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0] constrainedToSize:CGSizeMake(tableView.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    
//    CGRect frame = tableView.frame;
//    tableView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, constrainSize.height+10+44*question.answers.count);
//    
//    return constrainSize.height+10;
    return 90;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    for (int i=0; i<[self tableView:tableView numberOfRowsInSection:0]; ++i) {
//        if (i!=indexPath.row) {
//            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
//        }
//    }
//    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
//    
//    if (![self.submitBtn isEnabled]) {
//        [self.submitBtn setEnabled:YES];
//    }
//    
//    selectRow = indexPath.row;
    
    if (![self.submitBtn isEnabled]) {
        [self.submitBtn setEnabled:YES];
        [self.resultLabel setHidden:NO];
    }
    
    //determin if correct
    BOOL correct = (indexPath.row == question.right_answer);
    if (correct) {
        UIImageView* accessory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_ok.png"]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryView:accessory];
        [accessory release];
        
        UIImageView* view = (UIImageView*)[self.ratingView viewWithTag:step];
        [view setImage:[UIImage imageNamed:@"ok.png"]];
        
        int qIdx = [[DataManager sharedInstance] blockIdx]*questions_per_block+step;
        [[DataManager sharedInstance] answerQuestion:qIdx Result:1];
        
        [score addObject:[NSNumber numberWithInt:1]];
        
        stars++;
        
    }else {
        UIImageView* accessory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_erro.png"]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryView:accessory];
        [accessory release];
        
        accessory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_ok.png"]];
        [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:question.right_answer inSection:0]] setAccessoryView:accessory];
        [accessory release];
        
        UIImageView* view = (UIImageView*)[self.ratingView viewWithTag:step];
        [view setImage:[UIImage imageNamed:@"error.png"]];
        
        int qIdx = [[DataManager sharedInstance] blockIdx]*questions_per_block+step;
        [[DataManager sharedInstance] answerQuestion:qIdx Result:2];
        
        [score addObject:[NSNumber numberWithInt:2]];
    }
    [tableView setUserInteractionEnabled:NO];
}


#pragma mark - CustomAlertViewDelegate
-(void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        if (self.idx<last_block && self.idx>=[[DataManager sharedInstance] unlockIdx])
        {
            [[DataManager sharedInstance] setUnlockIdx:self.idx+1];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(buttonIndex == 1){
        //进入抽奖页面
        RollingViewController *rollingController = [[RollingViewController alloc] init];
        [self.navigationController pushViewController:rollingController animated:YES];
        [rollingController release];
    }else {
        [self showAWSheet];
    }
}

- (void)dealloc {
    [_ratingView release];
    [_resultView release];
    [_resultLabel release];
    [_questionView release];
    [_submitBtn release];
    [_tipLabel release];
    [_contentBg release];
    [super dealloc];
}

#pragma mark 
@end
