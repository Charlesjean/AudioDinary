//
//  ADGeneralViewController.h
//  AudioDinary
//
//  Created by Chen Duanjin on 9/7/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"
#import "ADNewVoiceViewController.h"

@interface ADGeneralViewController : UIViewController <TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource, ADNewVoiceViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UIButton *voiceButton;

@property (retain, nonatomic) IBOutlet UIButton *noteButton;

@property(nonatomic, retain)IBOutlet TKCalendarMonthView* calanderView;
@end
