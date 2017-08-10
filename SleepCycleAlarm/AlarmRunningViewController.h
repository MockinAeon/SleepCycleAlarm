//
//  AlarmRunningViewController.h
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/18/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmRunningViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton2;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property NSDate *wakeUp1;
@property NSDate *wakeUp2;
@property NSDate *sleepDate;
@end
