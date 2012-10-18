//
//  GXGesturedButton.m
//  Thueyts
//
//  Created by Mathieu Godart on 09/07/10.
//  Copyright 2010 Cogetic. All rights reserved.
//

#import "GXGesturedButton.h"


@implementation GXGesturedButton


@synthesize target;


/*
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
    }
    return self;
}
*/

- (void)addAction:(SEL)action forControlEvent:(GXGesturedButtonEvent)controlEvent {

    UIGestureRecognizer *recognizer = nil;

    switch (controlEvent) {
        case GXGesturedButtonEventSwipeUp:
            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
            ((UISwipeGestureRecognizer *)recognizer).direction = UISwipeGestureRecognizerDirectionUp;
            [self addGestureRecognizer:recognizer];
            swipeUpAction = action;
            break;
            
        case GXGesturedButtonEventSwipeDown:
            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
            ((UISwipeGestureRecognizer *)recognizer).direction = UISwipeGestureRecognizerDirectionDown;
            [self addGestureRecognizer:recognizer];
            swipeDownAction = action;
            break;
            
        case GXGesturedButtonEventSwipeRight:
            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
            ((UISwipeGestureRecognizer *)recognizer).direction = UISwipeGestureRecognizerDirectionRight;
            [self addGestureRecognizer:recognizer];
            swipeRightAction = action;
            break;
            
        case GXGesturedButtonEventSwipeLeft:
            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
            ((UISwipeGestureRecognizer *)recognizer).direction = UISwipeGestureRecognizerDirectionLeft;
            [self addGestureRecognizer:recognizer];
            swipeLeftAction = action;
            break;
            
        case GXGesturedButtonEventTapTwoFingers:
            recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
            ((UITapGestureRecognizer *)recognizer).numberOfTouchesRequired = 2;
            [self addGestureRecognizer:recognizer];
            tapTwoFingersAction = action;
            break;
            
        case GXGesturedButtonEventTapHalfUp:
            recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [self addGestureRecognizer:recognizer];
            tapHalfUpAction = action;
            break;

        case GXGesturedButtonEventTapHalfDown:
            recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [self addGestureRecognizer:recognizer];
            tapHalfDownAction = action;
            break;
            
        default:
            return;
    }

    [recognizer release];
}


- (void)handleTap:(UITapGestureRecognizer *)sender {

    CGPoint touchLocation = [sender locationInView:self];
    
    if (touchLocation.y < (self.frame.size.height / 2)) {
        // Upper half.
        [self sendAction:tapHalfUpAction to:target forEvent:nil];
    }
    else {
        // Second half.
        [self sendAction:tapHalfDownAction to:target forEvent:nil];
    }
}


- (void)dealloc {
    [super dealloc];
    [target release];
}


@end
