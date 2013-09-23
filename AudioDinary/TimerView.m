//
//  TimerView.m
//  AudioDinary
//
//  Created by Chen Duanjin on 9/19/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import "TimerView.h"

@interface TimerView()
{
    NSDate* startTime;
    NSTimer* timeRecorder;
    int hours;
    int minutes;
    int seconds;
    NSDateComponents* currentTimeComponent;
}
@end

@implementation TimerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    hours = 0;
    minutes = 0;
    seconds = 0;
    currentTimeComponent = [[NSDateComponents alloc] init] ;
    [currentTimeComponent setHour:hours];
    [currentTimeComponent setMinute: minutes];
    [currentTimeComponent setSecond:seconds];
    [self setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:25]];
    NSString* str = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours, minutes, seconds ];
    [self setText:str];
    return self;
}

- (void)startTimer
{
    startTime = [[NSDate date] retain];
    timeRecorder = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimeText) userInfo:NULL repeats:YES];
}

- (void)pauseTimer
{
    [timeRecorder invalidate];
    if (currentTimeComponent != nil) {
        [currentTimeComponent release];
    }
    currentTimeComponent = [[NSDateComponents alloc] init] ;
    [currentTimeComponent setHour:hours];
    [currentTimeComponent setMinute:minutes];
    [currentTimeComponent setSecond:seconds];

}

- (void)updateTimeText
{
    NSDate* currentTime = [NSDate date];
    NSCalendar* cal = [NSCalendar currentCalendar];
    unsigned int flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* component = [cal components:flags fromDate:startTime toDate:currentTime options:0];
    
    int ds = (component.second + currentTimeComponent.second)%60;
    int dm = (component.minute + currentTimeComponent.minute + (component.second + currentTimeComponent.second)/60)%60;
    int dh = (component.hour + currentTimeComponent.hour + (component.minute + currentTimeComponent.minute + (component.second + currentTimeComponent.second)/60)/60);
    
    NSString* str = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",dh, dm, ds ];
    hours = dh;
    minutes = dm;
    seconds = ds;
    [self setText:str];
}

@end
