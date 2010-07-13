//
//  FlipsideViewController.h
//  Thueyts
//
//  Created by Mathieu Godart on 21/06/10.
//  Copyright Coolsand 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#define YGO_MODE_KEY @"ygoMode"

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
    UISwitch *ygoModeSwitch;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UISwitch* ygoModeSwitch;

- (IBAction)done:(id)sender;
- (IBAction)ygoModeChanged:(UISwitch *)sender;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

