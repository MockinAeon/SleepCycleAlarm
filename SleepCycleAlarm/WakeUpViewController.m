//
//  WakeUpViewController.m
//  SleepCycle
//
//  Created by Mockin_Aeon. on 4/22/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "WakeUpViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface WakeUpViewController ()
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
@property NSTimer *timer;
@property AVAudioPlayer *audioPlayer;
@end

@implementation WakeUpViewController
@synthesize  timer = _timer;
@synthesize  timeLabel = _timeLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction:)];
    self.swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:self.swipe];
    [self timerFunc];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
    
    //audio
    NSUserDefaults *mySettingDataR =[NSUserDefaults standardUserDefaults];
    NSString *string= [[@"sound" stringByAppendingString:[NSString stringWithFormat:@"%ld",[mySettingDataR integerForKey:@"lastSelectedIndex"] + 1]]  stringByAppendingString:@".mp3"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:string withExtension:nil];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    if (self.audioPlayer) {
        NSLog(@"123213123");
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
}

-(void)timerFunc {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"HH:mm"];
    NSString *timestamp = [fmt stringFromDate:[NSDate date]];
    [_timeLabel setText:timestamp];
}

- (IBAction)swipeDownAction:(UIGestureRecognizer*) gesture {
    [self.audioPlayer stop];
    [self.backButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
