//
//  TabBarViewController.m
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/16/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UITabBar appearance].translucent = YES;
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_img.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
