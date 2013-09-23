//
//  ADNewNoteViewController.m
//  AudioDinary
//
//  Created by Chen Duanjin on 9/23/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import "ADNewNoteViewController.h"

@interface ADNewNoteViewController ()

@end

@implementation ADNewNoteViewController
@synthesize closeButton = _closeButton;
@synthesize saveButton = _saveButton;
@synthesize delegate;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_closeButton setTarget:self];
    [_closeButton setAction:@selector(close)];
    [_saveButton setTarget:self];
    [_saveButton setAction:@selector(save)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)dealloc {
    [_closeButton release];
    [_saveButton release];
    [super dealloc];
}

- (void)close
{
    [delegate ADNewVoiceViewControllerDidClose:self];
}

- (void)save
{
    [delegate ADNewVoiceViewControllerDidSave:self];
}


@end
