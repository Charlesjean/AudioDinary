//
//  ADNewNoteViewController.h
//  AudioDinary
//
//  Created by Chen Duanjin on 9/23/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADNewVoiceViewController.h"

@interface ADNewNoteViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property(nonatomic, assign)id<ADNewVoiceViewControllerDelegate> delegate;

@end
