//
//  GXGesturedButton.h
//  Thueyts
//
//  Created by Mathieu Godart on 09/07/10.
//  Copyright 2010 Cogetic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXGesturedButton : UIButton {
	id target;
    SEL swipeUpAction;
    SEL swipeDownAction;
    SEL swipeRightAction;
    SEL swipeLeftAction;
    SEL tapHalfUpAction;
    SEL tapHalfDownAction;
    SEL tapTwoFingersAction;
}

typedef NSUInteger GXGesturedButtonEvent;

enum {
    GXGesturedButtonEventSwipeUp       = 1 << 0,
    GXGesturedButtonEventSwipeDown     = 1 << 1,
    GXGesturedButtonEventSwipeLeft     = 1 << 2,
    GXGesturedButtonEventSwipeRight    = 1 << 3,
    GXGesturedButtonEventTapHalfUp     = 1 << 4,
    GXGesturedButtonEventTapHalfDown   = 1 << 5,
    GXGesturedButtonEventTapTwoFingers = 1 << 6
};

@property (nonatomic, retain) IBOutlet id target;

// TODO: Add a protocol here. Action must respond to action:(id)sender.
- (void)addAction:(SEL)action forControlEvent:(GXGesturedButtonEvent)controlEvent;

- (void)handleTap:(UITapGestureRecognizer *)sender;

@end
