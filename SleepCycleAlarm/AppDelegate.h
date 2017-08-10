//
//  AppDelegate.h
//  SleepCycleAlarm
//
//  Created by Mockin_Aeon. on 4/13/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UIWindow *window;

- (void)saveContext;
@end

