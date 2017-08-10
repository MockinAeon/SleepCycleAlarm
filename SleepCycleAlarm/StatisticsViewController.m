//
//  StatisticsViewController.m
//  SleepCycle
//
//  Created by Mockin_Aeon. on 4/28/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "StatisticsViewController.h"
#import "AppDelegate.h"
#import "Sleeping+CoreDataClass.h"
@interface StatisticsViewController ()
@property (nonatomic, strong) AppDelegate *appdelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *array;
@end

@implementation StatisticsViewController
@synthesize array = _array;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}
- (void) viewWillAppear:(BOOL)animated {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *restaurantentity = [NSEntityDescription entityForName:@"Sleeping" inManagedObjectContext:self.appdelegate.persistentContainer.viewContext];
    [fetchRequest setEntity:restaurantentity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appdelegate.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error%@",error);
    }else{
        _array = fetchedObjects;
        //        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        //        [fmt setDateFormat:@"MM-dd HH:mm:ss"];
        //        NSLog(@"%lu", (unsigned long)fetchedObjects.count);
        //        Sleeping *sleeping = fetchedObjects[0];
        //        NSLog(@"Start: = %@", [fmt stringFromDate:sleeping.startTime]);
        //        NSLog(@"Wake up: = %@", [fmt stringFromDate:sleeping.wakeTime]);
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"myTitleCell" forIndexPath:indexPath];
    }else {
        Sleeping *sleeping = _array[indexPath.row - 1];
        cell = [tableView dequeueReusableCellWithIdentifier:@"mySleepingCell" forIndexPath:indexPath];
        NSDateFormatter *month = [[NSDateFormatter alloc]init];
        [month setDateFormat:@"MMM dd"];
        NSDateFormatter *minute = [[NSDateFormatter alloc]init];
        [minute setDateFormat:@"HH:mm"];
        UILabel *monthLabel = (UILabel *) [cell viewWithTag:1];
        monthLabel.text = [month stringFromDate:sleeping.startTime];
        
        UILabel *bedLabel = (UILabel *) [cell viewWithTag:2];
        bedLabel.text = [[[minute stringFromDate:sleeping.startTime] stringByAppendingString:@" - "] stringByAppendingString:[minute stringFromDate:sleeping.wakeTime]];

        UILabel *timeLabel = (UILabel *) [cell viewWithTag:4];
        NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *cmps = [calendar components:type fromDate:sleeping.startTime toDate:sleeping.wakeTime options:0];
//        NSLog(@"%ld", (long)cmps.second);
        //timeLabel.text = [NSString stringWithFormat:@"%ldh %ldm", (long)cmps.hour, (long)cmps.minute];
        timeLabel.text = [NSString stringWithFormat:@"%ldm %lds", (long)cmps.minute, (long)cmps.second];
        
        UIProgressView *progress = (UIProgressView *) [cell viewWithTag:3];
        NSUserDefaults *mySettingDataR = [NSUserDefaults standardUserDefaults];
        float max = [mySettingDataR floatForKey:@"maxTime"];
        float sleepingTime = cmps.hour * 60 * 60 + cmps.minute * 60 + cmps.second;
        progress.progress = sleepingTime / max;
    }
    return cell;
    
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
