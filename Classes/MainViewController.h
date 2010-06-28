//
//  MainViewController.h
//  Thueyts
//
//  Created by Mathieu Godart on 21/06/10.
//  Copyright Coolsand 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIActionSheetDelegate> {
    
    BOOL gameRunning;
    NSTimer *timer;
    NSDate *startDate;
    
    UIButton *startStopButton;
    UIButton *timerButton;
    
    NSInteger myLife;
    NSInteger opLife;
    
    UILabel *myLifeView;
    UILabel *opLifeView;
    UILabel *myLifeRvView;
    UILabel *opLifeRvView;
    UILabel *myLifeRvLabel;
    UILabel *opLifeRvLabel;
}

@property (nonatomic, getter=isGameRunning) BOOL gameRunning;

@property (nonatomic, retain) IBOutlet NSTimer *timer;
@property (nonatomic, retain) IBOutlet NSDate *startDate;

@property (nonatomic, retain) IBOutlet UIButton *startStopButton;
@property (nonatomic, retain) IBOutlet UIButton *timerButton;

@property (nonatomic) NSInteger myLife;
@property (nonatomic) NSInteger opLife;

@property (nonatomic, retain) IBOutlet UILabel *myLifeView;
@property (nonatomic, retain) IBOutlet UILabel *opLifeView;
@property (nonatomic, retain) IBOutlet UILabel *myLifeRvView;
@property (nonatomic, retain) IBOutlet UILabel *opLifeRvView;
@property (nonatomic, retain) IBOutlet UILabel *myLifeRvLabel;
@property (nonatomic, retain) IBOutlet UILabel *opLifeRvLabel;

- (void)resetGameState;

- (IBAction)startStopGame;
- (void)setGameRunning:(BOOL)running;

- (void)setTimerRunning:(BOOL)running;
- (void)updateTimerView;
    
- (IBAction)increaseMyLife:(id)sender;
- (IBAction)increaseOpLife:(id)sender;
- (IBAction)decreaseMyLife:(id)sender;
- (IBAction)decreaseOpLife:(id)sender;

- (void)wiggleView:(UIView *)aView withIntensity:(CGFloat)intensity;

- (IBAction)showInfo:(id)sender;

@end
