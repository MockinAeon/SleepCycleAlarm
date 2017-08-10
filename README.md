<div align=center><img width="120" height="120" src="https://github.com/MockinAeon/SleepCycleAlarm/blob/master/SleepCycleAlarm/Assets.xcassets/icon.imageset/123-2.jpeg"/></div>

# SleepCycleAlarm
An iOS app to help users fall asleep and wake up according to their own sleep cycle.<br>
<br>
## Problem
Sleeping is very important for everybody, but things may happen when we want to sleep or after getting up: can’t fall asleep, feel tired after getting up?
## Solution
For the first problem, you notice you can fall asleep when it is raining? That’s because the noise of the rain is similar to white noise, which is helpful for people to fall asleep. So there is a function in my app to play some sound (chirp of bugs, sound of wind, sound of rain, sound of bell, sound of stream) to help you fall asleep.<br>
For the second problem, while you sleep, you go through several cycles of sleep states. The first state in a sleep cycle is light sleep, then deep sleep and a dream state referred to as REM-sleep. A full cycle lasts about 90 minutes. If you were waken up by your alarm while you were in a deep sleep state, your body can be exhausted. So the main function of my app is to calculate the time of your sleep cycle and depends on it, you can set an alarm which wake you up when you are in a light sleep state.<br>

## Demo & Work Flow

### Toppltips
For first-time user, there are some tips to get to know the work flow.<br>
<div align=center><img src="https://github.com/MockinAeon/SleepCycleAlarm/blob/master/gif/first%20time%20tips.gif"/></div>

### Measure sleep cycle
According to multiple sleep cycle measurements, caculate the average sleep cycle for alrm.<br>
<div align=center><img src="https://github.com/MockinAeon/SleepCycleAlarm/blob/master/gif/mesear%20sleep%20cycle.gif"/></div>

### Alarm
Set wake up time interval, alarm when users are in light sleep state.<br>
<div align=center><img src="https://github.com/MockinAeon/SleepCycleAlarm/blob/master/gif/alarm%20mode.gif"/></div>

### Sleep Records
<div align=center><img src="https://github.com/MockinAeon/SleepCycleAlarm/blob/master/gif/sleep%20records.gif"/></div>

### Sleep Sound
<div align=center><img src="https://github.com/MockinAeon/SleepCycleAlarm/blob/master/gif/Sleep%20sound.gif"/></div>

### Other Settings
<div align=center><img src="https://github.com/MockinAeon/SleepCycleAlarm/blob/master/gif/Other%20Settings.gif"/></div>

## Something more
1.	I use custom segue to create the animation when going to another view. <br>
2.	I use swipe gesture for going back from alarm, as you are just wake up, it is hard to click a small button. <br>
3.	When it’s time to alarm, if the app is on foreground, just play the wake up sound using AVAudioPlay, if it is in background, I set a local notification to play the sound. <br>
4.	I use NSUserDefaults to store some user data and when reopen the app, it will be initialized exactly the same when you stop the app. <br>

## Last
In the future, there are some more improvements:
1.	Add My Account, to backup user data online.  <br>
2.	Add snooze function, to allow user to snooze for some time after the first alarm. <br>
3.	Make the statistic fancier, use some chart to display it. <br>
4.	Use microphone or accelerators to detect users’ movements and calculate the time of sleep cycle. <br>
5.	Improve the swipe gesture (the view will follow finger). <br>

