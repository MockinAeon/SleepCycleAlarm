//
//  TestCycleViewController.h
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/17/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCycleViewController : UIViewController
@property (strong, nonatomic)  NSDate *testStartTime;
@property (strong, nonatomic)  NSDate *testEndTime;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@end
