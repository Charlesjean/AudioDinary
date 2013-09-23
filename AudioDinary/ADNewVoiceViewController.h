//
//  ADNewVoiceViewController.h
//  AudioDinary
//
//  Created by Chen Duanjin on 9/19/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerView.h"
#import "ADLevelMetricView.h"
@class ADNewVoiceViewController;


@protocol ADNewVoiceViewControllerDelegate <NSObject>
- (void)ADNewVoiceViewControllerDidClose:(UIViewController*) controller;
- (void)ADNewVoiceViewControllerDidSave:(UIViewController*) controller;
@end

@interface ADNewVoiceViewController : UIViewController
@property(nonatomic, assign)id<ADNewVoiceViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *saveVoiceButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (retain, nonatomic) IBOutlet UIButton *startPauseBtn;
@property (retain, nonatomic) IBOutlet UIButton *stopButton;
@property (retain, nonatomic) IBOutlet TimerView *timeLabel;
@property (retain, nonatomic) IBOutlet ADLevelMetricView *levelMetricView;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;

@end
