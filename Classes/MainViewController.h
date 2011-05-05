//
//  MainViewController.h
//  Thueyts
//
//  Created by Mathieu Godart on 21/06/10.
//  Copyright Coolsand 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"
#import "GXGesturedButton.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIActionSheetDelegate> {
    
    BOOL gameRunning;
    BOOL gameInYgoMode;
    NSTimer *timer;
    NSDate *startDate;
    
    UIButton *startStopButton;
    UIButton *timerButton;
    
    NSInteger myLife;
    NSInteger opLife;
    NSInteger lifeIncrement;
    NSInteger lifeIncrementLarge;
    
    UILabel *myLifeView;
    UILabel *opLifeView;
    UILabel *myLifeRvView;
    UILabel *opLifeRvView;
    UILabel *myLifeRvLabel;
    UILabel *opLifeRvLabel;
    UILabel *myPoisonLabel;
    UILabel *opPoisonLabel;
    UILabel *myPoisonRvLabel;
    UILabel *opPoisonRvLabel;

    GXGesturedButton *myLifeButton;
    GXGesturedButton *opLifeButton;
    GXGesturedButton *myLifeRvButton;
    GXGesturedButton *opLifeRvButton;
    
    UIView *customScoreView;
    UITextField *customScoreMyTextField;
    UITextField *customScoreOpTextField;
}

@property (nonatomic, getter=isGameRunning) BOOL gameRunning;
@property (nonatomic, getter=isGameInYgoMode) BOOL gameInYgoMode;

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSDate *startDate;

@property (nonatomic, retain) IBOutlet UIButton *startStopButton;
@property (nonatomic, retain) IBOutlet UIButton *timerButton;

@property (nonatomic) NSInteger myLife;
@property (nonatomic) NSInteger opLife;
@property (nonatomic) NSUInteger myPoisonMarkers;
@property (nonatomic) NSUInteger opPoisonMarkers;

@property (nonatomic, retain) IBOutlet UILabel *myLifeRvView;
@property (nonatomic, retain) IBOutlet UILabel *opLifeRvView;

@property (nonatomic, retain) IBOutlet UILabel *myLifeView;
@property (nonatomic, retain) IBOutlet UILabel *opLifeView;
@property (nonatomic, retain) IBOutlet UILabel *myLifeRvLabel;
@property (nonatomic, retain) IBOutlet UILabel *opLifeRvLabel;

@property (nonatomic, retain) IBOutlet UILabel *myPoisonLabel;
@property (nonatomic, retain) IBOutlet UILabel *opPoisonLabel;
@property (nonatomic, retain) IBOutlet UILabel *myPoisonRvLabel;
@property (nonatomic, retain) IBOutlet UILabel *opPoisonRvLabel;

@property (nonatomic, retain) IBOutlet GXGesturedButton *myLifeButton;
@property (nonatomic, retain) IBOutlet GXGesturedButton *opLifeButton;
@property (nonatomic, retain) IBOutlet GXGesturedButton *myLifeRvButton;
@property (nonatomic, retain) IBOutlet GXGesturedButton *opLifeRvButton;

@property (nonatomic, retain) IBOutlet UIView *customScoreView;
@property (nonatomic, retain) IBOutlet UITextField *customScoreMyTextField;
@property (nonatomic, retain) IBOutlet UITextField *customScoreOpTextField;

- (void)resetGameState;

- (IBAction)startStopGame;
- (void)setGameRunning:(BOOL)running;

- (IBAction)launchDice:(id)sender;

- (void)setTimerRunning:(BOOL)running;
- (void)updateTimerView;

- (IBAction)increaseMyLife:(id)sender;
- (IBAction)decreaseMyLife:(id)sender;
- (IBAction)increaseMyLifeLarge:(id)sender;
- (IBAction)decreaseMyLifeLarge:(id)sender;
- (IBAction)doubleMyLife:(id)sender;
- (IBAction)halveMyLife:(id)sender;
- (IBAction)customizeMyLife:(NSInteger)life;
- (IBAction)addMyPoisonMarker:(id)sender;
- (IBAction)removeMyPoisonMarker:(id)sender;

- (IBAction)increaseOpLife:(id)sender;
- (IBAction)decreaseOpLife:(id)sender;
- (IBAction)increaseOpLifeLarge:(id)sender;
- (IBAction)decreaseOpLifeLarge:(id)sender;
- (IBAction)doubleOpLife:(id)sender;
- (IBAction)halveOpLife:(id)sender;
- (IBAction)customizeOpLife:(NSInteger)life;
- (IBAction)addOpPoisonMarker:(id)sender;
- (IBAction)removeOpPoisonMarker:(id)sender;

- (void)wiggleView:(UIView *)aView withIntensity:(CGFloat)intensity;

- (IBAction)showCustomScoreView:(id)sender;
- (IBAction)showCustomMyScoreView:(id)sender;
- (IBAction)showCustomOpScoreView:(id)sender;
- (IBAction)hideCustomScoreView:(id)sender;
- (IBAction)validateCustomScoreView:(id)sender;

- (IBAction)showInfo:(id)sender;

@end
