//
//  TestCycleViewController.m
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/17/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "TestCycleViewController.h"
#import "AlarmViewController.h"
@interface TestCycleViewController ()
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
@property NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property NSInteger singleCycle;
- (IBAction)swipeDownAction:(id)sender;

@end

@implementation TestCycleViewController
@synthesize  timer = _timer;
@synthesize  timeLabel = _timeLabel;
@synthesize testStartTime = _testStartTime;
@synthesize testEndTime = _testEndTime;
@synthesize singleCycle = _singleCycle;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"HH:mm:ss"];
    NSLog(@"testcycleController _starttime = %@", [fmt stringFromDate:_testStartTime]);
    _testStartTime = [NSDate date];
    NSLog(@"testcycleController _starttime = %@", [fmt stringFromDate:_testStartTime]);
    
    self.swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction:)];
    self.swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:self.swipe];
    [self timerFunc];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
}


-(void)timerFunc {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"HH:mm"];
    NSString *timestamp = [fmt stringFromDate:[NSDate date]];
    [_timeLabel setText:timestamp];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"testCycleBack"]) {
        AlarmViewController *vc = (AlarmViewController*) segue.destinationViewController;
        _testEndTime = [NSDate date];
        //caculate sleep cycle
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *cmps = [calendar components:type fromDate:_testStartTime toDate:_testEndTime options:0];
        NSLog(@"Difference two dates: %ld hours %ld minutes %ld seconds",  cmps.hour, cmps.minute, cmps.second);
        NSInteger sleepingMinutes = 60 * cmps.hour + cmps.minute + cmps.second > 40 ? 1 : 0;
        NSInteger num = sleepingMinutes / 90;
        NSInteger remain = sleepingMinutes % 90;
        if (remain >= 45) num++;
//        _singleCycle = 0;
        
        //for test!!!
        _singleCycle = 91;
        
        if (num >= 4) {
            _singleCycle = sleepingMinutes / num;
        }
        vc.singleCycle = _singleCycle;
    }
}

- (IBAction)swipeDownAction:(UIGestureRecognizer*) gesture {
    [self.backButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}
@end
