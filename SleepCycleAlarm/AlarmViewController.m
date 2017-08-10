//
//  AlarmViewController.m
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/16/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "AlarmViewController.h"
#import "CustomPush.h"
#import "TestCycleViewController.h"
#import "HYNoticeView.h"
#import "AppDelegate.h"
#import "Sleeping+CoreDataClass.h"
@interface AlarmViewController ()
@property NSArray *pickerArray;
@property NSArray *minsArray;
@property NSInteger rowNumber;
@property NSUserDefaults *mySettingDataR;
@property BOOL fromTestCycle;
@property NSInteger cycleNum;
@property NSInteger minsNum;
@property NSDate *wakeUp1;
@property NSDate *wakeUp2;
@property NSDate *sleepDate;
@property (nonatomic, strong) AppDelegate *appdelegate;
@end

@implementation AlarmViewController
@synthesize cycleNumPicker = _cycleNumPicker;
@synthesize minPicker = _minPicker;
@synthesize pickerArray = _pickerArray;
@synthesize minsArray = _minsArray;
@synthesize rowNumber = _rowNumber;
@synthesize messageLabel = _messageLabel;
@synthesize leftBtn = _leftBtn;
@synthesize rightBtn = _rightBtn;
@synthesize cycleStartBtn = _cycleStartBtn;
@synthesize alarmStartBtn = _alarmStartBtn;
@synthesize testStartTime = _testStartTime;
@synthesize testEndTime = _testEndTime;
@synthesize singleCycle = _singleCycle;
@synthesize fromTestCycle = _fromTestCycle;
@synthesize mySettingDataR = _mySettingDataR;
@synthesize cycleNum = _cycleNum;
@synthesize minsNum = _minsNum;
@synthesize wakeUp1 = _wakeUp1;
@synthesize wakeUp2 = _wakeUp2;
@synthesize sleepDate = _sleepDate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.tabBarController.delegate = self;
    _mySettingDataR = [NSUserDefaults standardUserDefaults];
    
    //picker initialize
    _rowNumber = [_mySettingDataR integerForKey:@"cycleRowNumber"];
    NSInteger minsRowNumber = [_mySettingDataR integerForKey:@"minsRowNumber"];
    _cycleNumPicker.delegate = self;
    _cycleNumPicker.dataSource = self;
    _minPicker.delegate = self;
    _minPicker.dataSource = self;
    _minsArray = @[@"0",@"5",@"10",@"15",@"20",@"25",@"30"];
    _pickerArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    [_cycleNumPicker selectRow:_rowNumber inComponent:0 animated:YES];
    [_minPicker selectRow:minsRowNumber inComponent:0 animated:YES];
    
    //create first start tips
    BOOL first = [_mySettingDataR objectForKey:@"firstLaunch"];
    if (!first) {
        [_mySettingDataR setBool:YES forKey:@"firstLaunch"];
        HYNoticeView *noticeBottom = [[HYNoticeView alloc] initWithFrame:CGRectMake(117, 475, 140, 35) text:@"Start your alarm." position:HYNoticeViewPositionBottom closeBlock:^{
        } noticeBlock:^{
        }];
        
        HYNoticeView *noticeCenter = [[HYNoticeView alloc] initWithFrame:CGRectMake(95, 325, 190, 35) text:@"Check the wake up time." position:HYNoticeViewPositionBottom closeBlock:^{
            [noticeBottom showType:HYNoticeTypeTestSearch inView:self.view after:0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom];
        } noticeBlock:^{
        }];
        
        HYNoticeView *noticeCenterRight = [[HYNoticeView alloc] initWithFrame:CGRectMake(160, 210, 160, 35) text:@"Adjust the minutes." position:HYNoticeViewPositionBottom closeBlock:^{
            [noticeCenter showType:HYNoticeTypeTestSearch inView:self.view after:0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom];
        } noticeBlock:^{
        }];
        
        HYNoticeView *noticeCenterLeft = [[HYNoticeView alloc] initWithFrame:CGRectMake(5, 210, 260, 35) text:@"Choose the sleep cycle you want." position:HYNoticeViewPositionBottom closeBlock:^{
            [noticeCenterRight showType:HYNoticeTypeTestSearch inView:self.view after:0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom];
        } noticeBlock:^{
        }];
        
        HYNoticeView *noticeTopRight = [[HYNoticeView alloc] initWithFrame:CGRectMake(120, 30, 200, 35) text:@"Manage music and sound." position:HYNoticeViewPositionRight closeBlock:^{
            [noticeCenterLeft showType:HYNoticeTypeTestSearch inView:self.view after:0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom];
        } noticeBlock:^{
        }];
        
        HYNoticeView *noticeTopLeft = [[HYNoticeView alloc] initWithFrame:CGRectMake(50, 30, 160, 35) text:@"Switch in 2 modes." position:HYNoticeViewPositionLeft closeBlock:^{
            [noticeTopRight showType:HYNoticeTypeTestSearch inView:self.view after:0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom];
        } noticeBlock:^{
        }];
        [noticeTopLeft showType:HYNoticeTypeTestSearch inView:self.view after:0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self reloadView];
}
- (void) reloadView{
    BOOL testCycle = [_mySettingDataR boolForKey:@"testCycle"];
    if (testCycle) {
        //switch to cycle test mode
        [_cycleStartBtn setHidden:NO];
        [_alarmStartBtn setHidden:YES];
        [_rightBtn setHidden:YES];
        [_cycleNumPicker setHidden:YES];
        [_minPicker setHidden:YES];
        [_leftBtn setImage:[UIImage imageNamed:@"test2"] forState:UIControlStateNormal];
        [_leftBtn setTitle:@"Alarm Off" forState:UIControlStateNormal];
        _messageLabel.text = @"No alarm. Only sleep cycle measured.";
    }else {
        //switch to alarm mode
        [_cycleStartBtn setHidden:YES];
        [_alarmStartBtn setHidden:NO];
        [_rightBtn setHidden:NO];
        [_cycleNumPicker setHidden:NO];
        [_minPicker setHidden:NO];
        [_leftBtn setImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
        [_leftBtn setTitle:@"" forState:UIControlStateNormal];
        [self caculateTime];
    }
}

-(UIView*) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextColor:[UIColor whiteColor]];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        [_mySettingDataR setInteger:row forKey:@"cycleRowNumber"];
//        NSLog(@"cycle picker : %ld", (long)row);
    }else if (pickerView.tag == 2){
        [_mySettingDataR setInteger:row forKey:@"minsRowNumber"];
//        NSLog(@"mins picker : %ld", (long)row);
    }
    [self caculateTime];
}

-(NSInteger) caculateTime {
    NSInteger sleepingTime = 0;
    _cycleNum = [_mySettingDataR integerForKey:@"cycleRowNumber"];
    _minsNum = [_mySettingDataR integerForKey:@"minsRowNumber"];
    _singleCycle = [_mySettingDataR integerForKey:@"singleCycle"];
    sleepingTime = _cycleNum * _singleCycle;
//    NSLog(@"_cycleNum:%ld, _singleCycle:%ld, _minsNum:%ld, sleeping Time:%ld", (long)_cycleNum,(long)_singleCycle,(long)_minsNum,(long)sleepingTime);
    NSTimeInterval timeInterval1 = sleepingTime * 60;
    _sleepDate = [NSDate date];
    _wakeUp1 = [_sleepDate dateByAddingTimeInterval:timeInterval1];
    NSTimeInterval timeInterval2 = [_minsArray[_minsNum] intValue] * 60;
    _wakeUp2 = [_wakeUp1 dateByAddingTimeInterval:timeInterval2];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"HH:mm"];
    _messageLabel.text = [[[@"Wake up between " stringByAppendingString:[fmt stringFromDate:_wakeUp1]] stringByAppendingString:@" - "] stringByAppendingString:[fmt stringFromDate:_wakeUp2]];
    return sleepingTime;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return _pickerArray.count;
    } else if (pickerView.tag == 2) {
        return _minsArray.count;
    }
    return 0;
}
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return _pickerArray[row];
    } else if (pickerView.tag == 2) {
        return _minsArray[row];
    }
    return 0;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"enter segue");
    if ([segue.identifier isEqualToString:@"cycleMode"]) {
        UIViewController *vc = segue.destinationViewController;
        _testStartTime = [NSDate date];
        [vc setValue:_testStartTime forKey:@"testStartTime"];
    } else if ([segue.identifier isEqualToString:@"alarmMode"]) {
        UIViewController *vc = segue.destinationViewController;
        [vc setValue:_sleepDate forKey:@"sleepDate"];
        [vc setValue:_wakeUp1 forKey:@"wakeUp1"];
        [vc setValue:_wakeUp2 forKey:@"wakeUp2"];
    }

}
-(void) viewDidAppear:(BOOL)animated {
    if (_fromTestCycle) {
        NSString *message = [[@"Your sleeping cycle is " stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)_singleCycle]] stringByAppendingString:@" mins."];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sleeping Cycle" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction: ok];
        [self presentViewController: alert animated:YES completion:nil];
        _fromTestCycle = false;
    }
}

-(IBAction)returnedFromSegue:(UIStoryboardSegue*)segue {
//    NSLog(@"returnedFromSegue");
    if ([segue.identifier isEqualToString:@"testCycleBack"]) {
//        NSLog(@"singleCycle =   %ld", (long)_singleCycle );
        if (_singleCycle >= 60) {
            [_mySettingDataR setInteger:_singleCycle forKey:@"singleCycle"];
            _fromTestCycle = true;
        }
    } else if ([segue.identifier isEqualToString:@"backToAlarmingNow"]) {
//        NSLog(@"backToAlarmingNow");
        [self.alarmingBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else if ([segue.identifier isEqualToString:@"stopAlarming"]) {
        //save sleep data
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Sleeping" inManagedObjectContext:self.appdelegate.persistentContainer.viewContext];
        Sleeping *sleeping = [[Sleeping alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.appdelegate.persistentContainer.viewContext];
        sleeping.startTime = _sleepDate;
        sleeping.wakeTime = [NSDate date];
        [self.appdelegate saveContext];
        
        //save max time in nsuserdeaufts
        NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *cmps = [calendar components:type fromDate:sleeping.startTime toDate:sleeping.wakeTime options:0];
        float sleepingTime = cmps.hour * 60 * 60 + cmps.minute * 60 + cmps.second;
        float max = [_mySettingDataR integerForKey:@"maxTime"];
        if (max < sleepingTime){
            [_mySettingDataR setFloat:sleepingTime forKey:@"maxTime"];
        }
    }
}


- (IBAction)cycleTestAction:(id)sender {
    BOOL testCycle = [_mySettingDataR boolForKey:@"testCycle"];
    [_mySettingDataR setBool:!testCycle forKey:@"testCycle"];
    [self reloadView];
}

- (IBAction)runAlarmAction:(id)sender {

}

- (IBAction)runCycleAction:(id)sender {
    
}

-(void)hide{
    [HYNoticeView hideNoticeWithType:HYNoticeTypeTestTop];
}

@end
