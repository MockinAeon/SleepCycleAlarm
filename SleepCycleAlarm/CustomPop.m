//
//  CustomPop.m
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/17/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "CustomPop.h"

@implementation CustomPop
- (void)perform {
    UIView *sourceView = ((UIViewController *) self.sourceViewController).view;
    UIView *destinationView = ((UIViewController *) self.destinationViewController).view;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    destinationView.center = CGPointMake(sourceView.center.x, sourceView.center.y + 2 * destinationView.center.y);
    [window insertSubview:destinationView belowSubview:sourceView];
    
    [UIView animateWithDuration:0.8 animations:^{
        destinationView.center = CGPointMake(sourceView.center.x, sourceView.center.y);
        sourceView.center = CGPointMake(sourceView.center.x, 0 - 2 * destinationView.center.y);
    }
                     completion:^(BOOL finished) {
                         [[self destinationViewController] dismissViewControllerAnimated:NO completion:nil];
                     }
     ];
}

@end
