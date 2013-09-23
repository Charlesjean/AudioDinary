//
//  ADNewVoiceViewController.m
//  AudioDinary
//
//  Created by Chen Duanjin on 9/19/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import "ADNewVoiceViewController.h"

@interface ADNewVoiceViewController ()
{
    bool mIsRecording;
    UIImageView* imageView;
    NSTimer* animationTimer;
    NSMutableArray* levelArray;
}
@end

@implementation ADNewVoiceViewController

@synthesize delegate;
@synthesize saveVoiceButton = _saveVoiceButton;
@synthesize closeButton = _closeButton;
@synthesize timeLabel = _timeLabel;
@synthesize startPauseBtn = _startPauseBtn;
@synthesize stopButton = _stopButton;
@synthesize levelMetricView = _levelMetricView;
@synthesize dateLabel = _dateLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_saveVoiceButton setTarget:self];
    [_saveVoiceButton setAction:@selector(saveVoice)];
    [_closeButton setTarget:self];
    [_closeButton setAction:@selector(closeView)];
    [_startPauseBtn addTarget:self action:@selector(startPauseVoice) forControlEvents:UIControlEventTouchUpInside];
    [_stopButton addTarget:self action:@selector(stopVoice) forControlEvents:UIControlEventTouchUpInside];
    UIImage* image = [UIImage imageNamed:@"psd-microphone-icon-small.png"];
    imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - imageView.frame.size.height/8 )];
    [imageView setAlpha:0.0];
    [self.view addSubview:imageView];
    [imageView release];
    [self performSelector:@selector(showImage) withObject:self afterDelay:.5];
    mIsRecording = NO;
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDate* date = [NSDate date];
    int flag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit ;
    NSDateComponents* com = [cal components:flag fromDate:date];
    [_dateLabel setText:[NSString stringWithFormat:@"%.4d年%.2d月%.2d日,%.2d:%.2d", com.year,com.month,com.day,com.hour,com.minute]];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_saveVoiceButton release];
    [_closeButton release];
    [_startPauseBtn release];
    [_stopButton release];
    [_timeLabel release];
    [_levelMetricView release];
    if (levelArray != nil) {
        [levelArray release];
    }
    
    [_dateLabel release];
    [super dealloc];
}

- (void)saveVoice
{
    [self.delegate ADNewVoiceViewControllerDidSave:self];
}

- (void)closeView
{
    [self.delegate ADNewVoiceViewControllerDidClose:self];
}

- (void)startPauseVoice
{
    mIsRecording = mIsRecording ? NO : YES;
    if (mIsRecording)
    {
        [_timeLabel startTimer];
        animationTimer = [NSTimer scheduledTimerWithTimeInterval:1/8.0 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
    }
    else
    {
        [_timeLabel pauseTimer];
        [animationTimer invalidate];        
    }
       
}

- (void)stopVoice
{
    
}

- (void)showImage
{
    [UIView animateWithDuration:0.5 animations:^{
        [imageView setAlpha:1.0];
    }];
}

- (void)updateView
{
    if (levelArray == nil) {
         levelArray = [[NSMutableArray alloc] initWithCapacity:_levelMetricView.arrayLength / 2];
        for (int i =  0; i < _levelMetricView.arrayLength / 2; ++i) {
            [levelArray addObject:[NSNumber numberWithInt:rand()%22]];
        }
    }
    else{
        int newVol = rand()%15;
        for (int i = 0; i < _levelMetricView.arrayLength /2 -1; ++i) {
            [levelArray setObject:[levelArray objectAtIndex:i+1] atIndexedSubscript:i];
        }
        [levelArray setObject:[NSNumber numberWithInt:newVol]  atIndexedSubscript:_levelMetricView.arrayLength/2-1];
    }
    

    _levelMetricView.volumArray = [levelArray copy];
    //[array release];
    [_levelMetricView setNeedsDisplay];
}
@end
