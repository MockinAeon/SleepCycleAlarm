//
//  CustomNavigationViewController.m
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/17/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "CustomNavigationViewController.h"
#import "CustomPop.h"
@interface CustomNavigationViewController ()

@end

@implementation CustomNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStoryboardSegue *) segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier{
    if ([@"testCycleBack" isEqualToString:identifier] ||
        [@"alarmRunningBack" isEqualToString:identifier] ||
        [@"soundBack" isEqualToString:identifier] ||
        [@"stopAlarming" isEqualToString:identifier]) {
        return [[CustomPop alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    }
    else {
        return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
    }
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
