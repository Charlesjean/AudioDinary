//
//  ADGeneralViewController.m
//  AudioDinary
//
//  Created by Chen Duanjin on 9/7/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import "ADGeneralViewController.h"
#import "ADNewVoiceViewController.h"
#import "ADNewNoteViewController.h"
@interface ADGeneralViewController ()

@end

@implementation ADGeneralViewController

@synthesize calanderView = _calanderView;
@synthesize voiceButton = _voiceButton;
@synthesize noteButton = _noteButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_calanderView setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
    [_calanderView selectDate:[NSDate date]];
    [_calanderView setDelegate:self];
    [_calanderView setDataSource:self];
    [_voiceButton addTarget:self action:@selector(addNewVoice) forControlEvents:UIControlEventTouchUpInside];
    [_noteButton addTarget:self action:@selector(addNewNote) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNewNote
{
    
}
- (void)addNewVoice
{
    
}


- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
	return nil;
}

- (void)dealloc {
    [_noteButton release];
    [_voiceButton release];
    [super dealloc];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addvoicenote"]) {
        UINavigationController* navigation = segue.destinationViewController;
        ADNewVoiceViewController* voiceController = [[navigation viewControllers] objectAtIndex:0];
        voiceController.delegate = self;  
    }
    else if([segue.identifier isEqualToString:@"addnote"])
    {
        UINavigationController* navigation = segue.destinationViewController;
        ADNewNoteViewController* noteController = [[navigation viewControllers] objectAtIndex:0];
        noteController.delegate = self;        
    
    }


}

#pragma mark ADNewVoiceViewControllerDelegate method

- (void)ADNewVoiceViewControllerDidClose:(UIViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ADNewVoiceViewControllerDidSave:(UIViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
