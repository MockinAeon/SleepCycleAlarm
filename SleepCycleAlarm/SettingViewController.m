//
//  SettingViewController.m
//  SleepCycle
//
//  Created by Mockin_Aeon. on 4/25/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "SettingViewController.h"
#import <MessageUI/MessageUI.h>
@interface SettingViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *array;
@property NSArray *array2;
@end

@implementation SettingViewController
@synthesize array = _array;
@synthesize array2 = _array2;
- (void)viewDidLoad {
    [super viewDidLoad];
    _array = @[@"soundCell", @"vibrationCell", @"feedCell", @"aboutCell"];
    _array2 = @[@"Sound", @"Vibration", @"Feed Back", @"About"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:30 green:43 blue:54 alpha:0]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)  {
        return 1;
    }else {
        return _array.count / 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    UITableViewCell *cell;
    if (section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"myAccountCell" forIndexPath:indexPath];
        cell.textLabel.text = @"My Account";
    }else if (section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:_array[indexPath.row] forIndexPath:indexPath];
        cell.textLabel.text = _array2[indexPath.row];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:_array[section + indexPath.row] forIndexPath:indexPath];
        cell.textLabel.text = _array2[section + indexPath.row];
        
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textAlignment = UITextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2 && indexPath.row == 0) {
        MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
        if (!vc) {
            return;
        }
        vc.mailComposeDelegate = self;
        if ([MFMailComposeViewController canSendMail]) {
            [vc setSubject:@"App Feedback"];
            [vc setToRecipients:@[@"wang.xur@husky.neu.edu"]];
            [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // dismiss the mail composer
    [self dismissViewControllerAnimated:YES completion:nil];
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
