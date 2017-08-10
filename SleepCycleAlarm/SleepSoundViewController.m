//
//  SleepSoundViewController.m
//  SleepCycle
//
//  Created by Mockin_Aeon. on 4/28/17.
//  Copyright © 2017 Mockin_Aeon. All rights reserved.
//

#import "SleepSoundViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface SleepSoundViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISlider *sliderBar;
@property NSArray *array;
@property NSIndexPath *lastSelectedIndex;
@property NSUserDefaults *mySettingDataR;
@property AVAudioPlayer *audioPlayer;
@property float volume;
@property BOOL soundOn;
@end

@implementation SleepSoundViewController
@synthesize array = _array;
@synthesize lastSelectedIndex = _lastSelectedIndex;
@synthesize mySettingDataR = _mySettingDataR;
@synthesize volume = _volume;
@synthesize sliderBar = _sliderBar;
@synthesize soundOn = _soundOn;
- (void)viewDidLoad {
    [super viewDidLoad];
    _mySettingDataR =[NSUserDefaults standardUserDefaults];
    _array = @[@"Bell", @"Bug", @"Rain", @"Water", @"Wind"];
    //    , @"Sound5", @"Sound6", @"Sound7", @"Sound8", @"Sound9", @"Sound10"
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _lastSelectedIndex = [_mySettingDataR objectForKey:@"lastSelectedSleepingIndex"];
    
    _volume = [_mySettingDataR floatForKey:@"sleepVolume"];
    if (_volume == 0) _volume = 0.3f;
    NSInteger index = [_mySettingDataR integerForKey:@"lastSelectedSleepingIndex"];
    NSArray *array = @[@"Bell", @"Bug", @"Rain", @"Water", @"Wind"];
    NSString *string= [[@"sound-" stringByAppendingString:array[index]] stringByAppendingString:@".mp3"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:string withExtension:nil];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    if (self.audioPlayer) {
        [self.audioPlayer setNumberOfLoops:-1];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
}

-(void) viewWillAppear:(BOOL)animated {
    BOOL playSleepingSound = [_mySettingDataR boolForKey:@"playSleepingSound"];
    [_soundSwitch setOn:playSleepingSound];
    _soundOn = true;
    [self setBtnImage];
    [self.tableView reloadData];
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
        NSString *string= [@"sound-" stringByAppendingString:_array[indexPath.row]];
        UIImageView *img = (UIImageView*) [cell viewWithTag:1];
        img.image = [UIImage imageNamed:string];
        UILabel * text = (UILabel*) [cell viewWithTag:2];
        text.text = _array[indexPath.row];
        NSInteger index = [_mySettingDataR integerForKey:@"lastSelectedSleepingIndex"];
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
    NSString *string= [[@"sound-" stringByAppendingString:_array[indexPath.row]] stringByAppendingString:@".mp3"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:string withExtension:nil];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    if (self.audioPlayer) {
        [self.audioPlayer setNumberOfLoops:1];
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

-(void) viewWillDisappear:(BOOL)animated {
    [self.audioPlayer stop];
    [_mySettingDataR setInteger:_lastSelectedIndex.row forKey:@"lastSelectedSleepingIndex"];
    [_mySettingDataR setFloat:_volume forKey:@"sleepVolume"];
}

- (IBAction)sliderValue:(UISlider *)sender {
    _volume = sender.value;
    self.audioPlayer.volume = sender.value;
}


- (IBAction)soundBtnAction:(id)sender {
    [self setBtnImage];
}

-(void) setBtnImage {
    if (!_soundOn) {
        [self.audioPlayer stop];
        [self.audioPlayer setNumberOfLoops:-1];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        [self.soundBtn setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
    }else {
        [self.audioPlayer stop];
        [self.soundBtn setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    }
    _soundOn = !_soundOn;
}

- (IBAction)soundSwitchAction:(id)sender {
    BOOL isSwitchOn = [_soundSwitch isOn];
    if (isSwitchOn) {
        [_mySettingDataR setBool:YES forKey:@"playSleepingSound"];
    }else {
        [_mySettingDataR setBool:NO forKey:@"playSleepingSound"];
    }
}
@end
