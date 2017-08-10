//
//  AlarmRunningViewController.m
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/18/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "AlarmRunningViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
@interface AlarmRunningViewController ()
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
@property NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property UNUserNotificationCenter *center;
@property AVAudioPlayer *audioPlayer;
- (IBAction)swipeDownAction:(id)sender;
@end

@implementation AlarmRunningViewController
@synthesize  timer = _timer;
@synthesize  timeLabel = _timeLabel;
@synthesize wakeUp1 = _wakeUp1;
@synthesize wakeUp2 = _wakeUp2;
@synthesize center = _center;
@synthesize sleepDate = _sleepDate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction:)];
    self.swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:self.swipe];
    [self timerFunc];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"HH:mm"];
    
    self.textLabel.text = [[[@"Alarm " stringByAppendingString:[fmt stringFromDate:_wakeUp1]] stringByAppendingString:@" - "] stringByAppendingString:[fmt stringFromDate:_wakeUp2]];
    
    NSDate *now=[NSDate new];
    NSTimeInterval period = 10;
    NSDate *later = [now dateByAddingTimeInterval:period];
    
     _center = [UNUserNotificationCenter currentNotificationCenter];
    [_center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"request authorization succeeded!");
        }
    }];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"Alarm";
    content.body = @"Good Morning!";
//    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"sound.mp3"];
//    content.sound = sound;
    
    //random num for waking up time
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    _wakeUp1 = [_wakeUp1 dateByAddingTimeInterval:5];
    NSDateComponents *dateComponents = [greCalendar components:type fromDate:_wakeUp1];
    
    UNCalendarNotificationTrigger *trigger1 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:NO];
    NSString *requestIdentifier = @"alarmRequest";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                          content:content
                                                                          trigger:trigger1];
    [_center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
    //set sleeping soud
    NSUserDefaults *mySettingDataR = [NSUserDefaults standardUserDefaults];
    BOOL playSleepingSound = [mySettingDataR boolForKey:@"playSleepingSound"];
    if (playSleepingSound){
        NSInteger index = [mySettingDataR integerForKey:@"lastSelectedSleepingIndex"];
        NSArray *array = @[@"Bell", @"Bug", @"Rain", @"Water", @"Wind"];
        NSString *string= [[@"sound-" stringByAppendingString:array[index]] stringByAppendingString:@".mp3"];
        NSURL *url = [[NSBundle mainBundle] URLForResource:string withExtension:nil];
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        if (self.audioPlayer) {
            [self.audioPlayer setNumberOfLoops:-1];
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        }
    }
}


//-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)timerFunc {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"HH:mm"];
    NSDate *date = [NSDate date];
    NSString *timestamp = [fmt stringFromDate:date];
    [_timeLabel setText:timestamp];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:type fromDate:date toDate:_wakeUp1 options:0];
    if (cmps.hour == 0 && cmps.minute == 0 && cmps.second == 0) {
        //go back then go to wake up view
        [self.backButton2 sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    NSDateComponents *cmps2 = [calendar components:type fromDate:_sleepDate toDate:date options:0];
    if (cmps2.hour == 0 && cmps2.minute == 0  && cmps2.second == 5) {
        //go back then go to wake up view
        [self.audioPlayer stop];
    }
}

- (IBAction)swipeDownAction:(UIGestureRecognizer*) gesture {
    [self.audioPlayer stop];
    [_center removePendingNotificationRequestsWithIdentifiers:@[@"alarmRequest"]];
    [self.backButton sendActionsForControlEvents:UIControlEventTouchUpInside];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
