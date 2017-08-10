//
//  SleepSoundViewController.h
//  SleepCycle
//
//  Created by Mockin_Aeon. on 4/28/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepSoundViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UIButton *soundBtn;
- (IBAction)soundBtnAction:(id)sender;
- (IBAction)soundSwitchAction:(id)sender;

@end
