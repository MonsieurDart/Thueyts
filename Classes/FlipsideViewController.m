//
//  FlipsideViewController.m
//  Thueyts
//
//  Created by Mathieu Godart on 21/06/10.
//  Copyright Coolsand 2010. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate, ygoModeSwitch;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    ygoModeSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:YGO_MODE_KEY];
}


- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];
}


- (IBAction)ygoModeChanged:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:YGO_MODE_KEY];
    // This one should not be necessary, but it is easier for debug.
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
