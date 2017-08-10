//
//  AlarmViewController.h
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/16/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *cycleNumPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *minPicker;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *cycleStartBtn;
@property (weak, nonatomic) IBOutlet UIButton *alarmStartBtn;
@property (weak, nonatomic) IBOutlet UIButton *alarmingBtn;
@property NSDate *testStartTime;
@property NSDate *testEndTime;
@property NSInteger singleCycle;
- (IBAction)cycleTestAction:(id)sender;
- (IBAction)runAlarmAction:(id)sender;
- (IBAction)runCycleAction:(id)sender;
- (IBAction)returnedFromSegue:(UIStoryboardSegue*)gesture;

@end
