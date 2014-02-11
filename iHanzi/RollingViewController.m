//
//  RollingViewController.m
//  iHanzi
//
//  Created by Zhongwei Huang on 2/11/14.
//  Copyright (c) 2014 Zhongwei. All rights reserved.
//

#import "RollingViewController.h"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
@interface RollingViewController ()

@end

@implementation RollingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:YES];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    homeButton.frame = CGRectMake(0.0, 0.0, 26.0, 23.0);
    
    [homeButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    
    [homeButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
    
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    
    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
    
    [temporaryBarButtonItem release];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_rollingPad release];
    [super dealloc];
}

-(void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnClicked:(id)sender {
    [self rotationWithDuration:2 angle:DEGREES_TO_RADIANS(400) options:UIViewAnimationOptionCurveEaseInOut];
}

- (void)rotationWithDuration:(NSTimeInterval)duration angle:(CGFloat)angle options:(UIViewAnimationOptions)options
{
    // Repeat a quarter rotation as many times as needed to complete the full rotation
    CGFloat sign = angle > 0 ? 1 : -1;
    __block NSUInteger numberRepeats = floorf(fabsf(angle) / M_PI_2);
    CGFloat quarterDuration = duration * M_PI_2 / fabs(angle);
    
    CGFloat lastRotation = angle - sign * numberRepeats * M_PI_2;
    CGFloat lastDuration = duration - quarterDuration * numberRepeats;
    
//    __block UIViewAnimationOptions startOptions = UIViewAnimationOptionBeginFromCurrentState;
//    UIViewAnimationOptions endOptions = UIViewAnimationOptionBeginFromCurrentState;
//    
//    if (options & UIViewAnimationOptionCurveEaseIn || options == UIViewAnimationOptionCurveEaseInOut) {
//        startOptions |= UIViewAnimationOptionCurveEaseIn;
//    } else {
//        startOptions |= UIViewAnimationOptionCurveLinear;
//    }
//    
//    if (options & UIViewAnimationOptionCurveEaseOut || options == UIViewAnimationOptionCurveEaseInOut) {
//        endOptions |= UIViewAnimationOptionCurveEaseOut;
//    } else {
//        endOptions |= UIViewAnimationOptionCurveLinear;
//    }
    
    void (^lastRotationBlock)(void) = ^ {
        [UIView animateWithDuration:lastDuration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             //self.rollingPad.transform = CGAffineTransformRotate(self.rollingPad.transform, lastRotation);
                             self.rollingPad.layer.transform = CATransform3DRotate(self.rollingPad.layer.transform ,lastRotation,0.0, 0.0, 1.0);
                         }
                         completion:^(BOOL finished) {
                             NSLog(@"Animation completed");
                         }
         ];
    };
    
    __block void (^quarterSpinningBlock)(void) = [^{
        [UIView animateWithDuration:quarterDuration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             //self.rollingPad.transform = CGAffineTransformRotate(self.rollingPad.transform, M_PI_2);
                             self.rollingPad.layer.transform = CATransform3DRotate(self.rollingPad.layer.transform ,M_PI_2,0.0, 0.0, 1.0);
                             numberRepeats--;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 if (numberRepeats > 0) {
                                     quarterSpinningBlock();
                                     
                                 } else {
                                     lastRotationBlock();
                                     [quarterSpinningBlock autorelease];                                 }
                             }
                             
                         }
         ];
        
    } copy] ;
    
    
//    __block void (^myQuarterSpinningBlock)(void);
    
    
    
//    void (^myEaseOutBlock)(void) = ^{
//        [UIView animateWithDuration:2
//                              delay:0
//                            options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
//                         animations:^{
//                             self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
//                         } completion:^(BOOL finished) {
//                             
//                         }];
//    };
    
//    void (^myLastSpinningBlock)(void) = ^ {
//        [UIView animateWithDuration:lastDuration
//                              delay:0
//                            options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
//                         animations:^{
//                             self.transform = CGAffineTransformRotate(self.transform, lastRotation);
//                         }
//                         completion:^(BOOL finished) {
//                             NSLog(@"Animation completed");
//                         }
//         ];
//    };
//    
//    myQuarterSpinningBlock = [^{
//        [UIView animateWithDuration:quarterDuration
//                              delay:0
//                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
//                         animations:^{
//                             self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
//                             numberRepeats--;
//                         } completion:^(BOOL finished) {
//                             if (finished) {
//                                 if (numberRepeats > 0) {
//                                     myQuarterSpinningBlock();
//                                     
//                                 } else {
//                                     myLastSpinningBlock();
//                                     [myQuarterSpinningBlock autorelease];
//                                     
//                                     myEaseOutBlock();
//                                 }
//                             }
//                             
//                         }];
//    } copy];
//    
//    void (^myEaseInBlock)(void) = ^{
//        [UIView animateWithDuration:1
//                              delay:0
//                            options: UIViewAnimationOptionCurveEaseIn
//                         animations:^{
//                             
//                             self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
//                         } completion:^(BOOL finished) {
//                             if (finished) {
//                                 myQuarterSpinningBlock();
//                             }
//                             
//                         }];
//    };
    
        if (numberRepeats) {
    
                quarterSpinningBlock();
    
    
        } else {
            lastRotationBlock();
        }
}
@end
