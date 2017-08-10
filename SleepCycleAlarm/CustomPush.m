//
//  CustomPush.m
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/17/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "CustomPush.h"

@implementation CustomPush
- (void)perform {
    UIView *sourceView = ((UIViewController *) self.sourceViewController).view;
    UIView *destinationView = ((UIViewController *) self.destinationViewController).view;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    destinationView.center = CGPointMake(sourceView.center.x, sourceView.center.y - 2 * destinationView.center.y);
    [window insertSubview:destinationView aboveSubview:sourceView];
    [UIView animateWithDuration:0.8 animations:^{
        destinationView.center = CGPointMake(sourceView.center.x, sourceView.center.y);
        sourceView.center = CGPointMake(sourceView.center.x,  destinationView.center.y);
    }
     completion:^(BOOL finished) {
         [[self sourceViewController] presentViewController:[self destinationViewController] animated:NO completion:nil];
     }
     ];
}
@end
