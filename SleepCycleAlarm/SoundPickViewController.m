//
//  SoundPickViewController.m
//  SleepCycle
//
//  Created by Mockin_Aeon. on 4/23/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "SoundPickViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundPickViewController ()
- (IBAction)backAction:(id)sender;
- (IBAction)sliderValue:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *sliderBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property NSArray *array;
@property NSIndexPath *lastSelectedIndex;
@property NSUserDefaults *mySettingDataR;
@property AVAudioPlayer *audioPlayer;
@property float volume;
@end

@implementation SoundPickViewController
@synthesize array = _array;
@synthesize lastSelectedIndex = _lastSelectedIndex;
@synthesize mySettingDataR = _mySettingDataR;
@synthesize volume = _volume;
@synthesize sliderBar = _sliderBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    _mySettingDataR =[NSUserDefaults standardUserDefaults];
    _array = @[@"Sound1", @"Sound2", @"Sound3", @"Sound4"];
//    , @"Sound5", @"Sound6", @"Sound7", @"Sound8", @"Sound9", @"Sound10"
    self.tableView.backgroundColor = [UIColor clearColor];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    _lastSelectedIndex = [_mySettingDataR objectForKey:@"lastSelectedIndex"];
    
    _volume = [_mySettingDataR floatForKey:@"soundVolume"];
    if (_volume == 0) _volume = 0.3f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)  {
        return 1;
    }else {
        return _array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    UITableViewCell *cell;
    if (section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"mySliderCell" forIndexPath:indexPath];
        _sliderBar =(UISlider*) [cell viewWithTag:10];
        [_sliderBar setValue:_volume];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
        cell.textLabel.text = _array[indexPath.row];
        NSInteger index = [_mySettingDataR integerForKey:@"lastSelectedIndex"];
        if ((_lastSelectedIndex == nil && indexPath.row == 0) ||
            (_lastSelectedIndex == nil && indexPath.row == index) ||
            (indexPath.row == index)){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            _lastSelectedIndex = indexPath;
        }
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.audioPlayer stop];
    NSString *string= [[@"sound" stringByAppendingString:[NSString stringWithFormat:@"%ld",indexPath.row + 1]]  stringByAppendingString:@".mp3"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:string withExtension:nil];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    if (self.audioPlayer) {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
    if (indexPath == _lastSelectedIndex) return;
    UITableViewCell *newcell = [tableView cellForRowAtIndexPath:indexPath];
    newcell.accessoryType = UITableViewCellAccessoryCheckmark;
    UITableViewCell *oldcell = [tableView cellForRowAtIndexPath:_lastSelectedIndex];
    oldcell.accessoryType = UITableViewCellAccessoryNone;
    _lastSelectedIndex = indexPath;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    [self.audioPlayer stop];
    [_mySettingDataR setInteger:_lastSelectedIndex.row forKey:@"lastSelectedIndex"];
    [_mySettingDataR setFloat:_volume forKey:@"soundVolume"];
}
- (IBAction)sliderValue:(UISlider *)sender {
    _volume = sender.value;
    self.audioPlayer.volume = sender.value;
}
@end
