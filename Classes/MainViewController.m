//
//  MainViewController.m
//  Thueyts
//
//  Created by Mathieu Godart on 21/06/10.
//  Copyright L'atelier du mobile 2010. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/CAAnimation.h>


@implementation MainViewController

@synthesize myPoisonLabel;
@synthesize opPoisonLabel;
@synthesize myPoisonRvLabel;
@synthesize opPoisonRvLabel;


@synthesize gameRunning, gameInYgoMode, timer, startDate;
@synthesize startStopButton, timerButton;
@synthesize myLife, myPoisonMarkers, myLifeView, myLifeRvView, myLifeRvLabel;
@synthesize myLifeButton, myLifeRvButton;
@synthesize opLife, opPoisonMarkers, opLifeView, opLifeRvView, opLifeRvLabel;
@synthesize opLifeButton, opLifeRvButton;
@synthesize customScoreView, customScoreMyTextField, customScoreOpTextField;


#pragma mark -
#pragma mark - View & Game Setup


// Add actions to the gesture buttons.
- (void)addGestureActions {
    
    // Add the actions to the gestured capable button.
    [myLifeButton addAction:@selector(increaseMyLife:)          forControlEvent:GXGesturedButtonEventTapHalfUp];
    [myLifeButton addAction:@selector(decreaseMyLife:)          forControlEvent:GXGesturedButtonEventTapHalfDown];
    [myLifeButton addAction:@selector(increaseMyLifeLarge:)     forControlEvent:GXGesturedButtonEventSwipeUp];
    [myLifeButton addAction:@selector(decreaseMyLifeLarge:)     forControlEvent:GXGesturedButtonEventSwipeDown];
    [myLifeButton addAction:@selector(doubleMyLife:)            forControlEvent:GXGesturedButtonEventSwipeRight];
    [myLifeButton addAction:@selector(halveMyLife:)             forControlEvent:GXGesturedButtonEventSwipeLeft];
    [myLifeButton addAction:@selector(showCustomMyScoreView:)   forControlEvent:GXGesturedButtonEventTapTwoFingers];
    
    [opLifeButton addAction:@selector(increaseOpLife:)          forControlEvent:GXGesturedButtonEventTapHalfUp];
    [opLifeButton addAction:@selector(decreaseOpLife:)          forControlEvent:GXGesturedButtonEventTapHalfDown];
    [opLifeButton addAction:@selector(increaseOpLifeLarge:)     forControlEvent:GXGesturedButtonEventSwipeUp];
    [opLifeButton addAction:@selector(decreaseOpLifeLarge:)     forControlEvent:GXGesturedButtonEventSwipeDown];
    [opLifeButton addAction:@selector(doubleOpLife:)            forControlEvent:GXGesturedButtonEventSwipeRight];
    [opLifeButton addAction:@selector(halveOpLife:)             forControlEvent:GXGesturedButtonEventSwipeLeft];
    [opLifeButton addAction:@selector(showCustomOpScoreView:)   forControlEvent:GXGesturedButtonEventTapTwoFingers];
    
    [myLifeRvButton addAction:@selector(decreaseMyLife:)        forControlEvent:GXGesturedButtonEventTapHalfUp];
    [myLifeRvButton addAction:@selector(increaseMyLife:)        forControlEvent:GXGesturedButtonEventTapHalfDown];
    [myLifeRvButton addAction:@selector(decreaseMyLifeLarge:)   forControlEvent:GXGesturedButtonEventSwipeUp];
    [myLifeRvButton addAction:@selector(increaseMyLifeLarge:)   forControlEvent:GXGesturedButtonEventSwipeDown];
    [myLifeRvButton addAction:@selector(doubleMyLife:)          forControlEvent:GXGesturedButtonEventSwipeLeft];
    [myLifeRvButton addAction:@selector(halveMyLife:)           forControlEvent:GXGesturedButtonEventSwipeRight];
    [myLifeRvButton addAction:@selector(showCustomMyScoreView:) forControlEvent:GXGesturedButtonEventTapTwoFingers];
    
    [opLifeRvButton addAction:@selector(decreaseOpLife:)        forControlEvent:GXGesturedButtonEventTapHalfUp];
    [opLifeRvButton addAction:@selector(increaseOpLife:)        forControlEvent:GXGesturedButtonEventTapHalfDown];
    [opLifeRvButton addAction:@selector(decreaseOpLifeLarge:)   forControlEvent:GXGesturedButtonEventSwipeUp];
    [opLifeRvButton addAction:@selector(increaseOpLifeLarge:)   forControlEvent:GXGesturedButtonEventSwipeDown];
    [opLifeRvButton addAction:@selector(doubleOpLife:)          forControlEvent:GXGesturedButtonEventSwipeLeft];
    [opLifeRvButton addAction:@selector(halveOpLife:)           forControlEvent:GXGesturedButtonEventSwipeRight];
    [opLifeRvButton addAction:@selector(showCustomOpScoreView:) forControlEvent:GXGesturedButtonEventTapTwoFingers];
    
    // Change the swipe actions for Magic mode. In this mode the swipe will add poison markers.
    if (self.gameInYgoMode == NO) {
        
        [myLifeButton addAction:@selector(addMyPoisonMarker:)       forControlEvent:GXGesturedButtonEventSwipeRight];
        [myLifeButton addAction:@selector(removeMyPoisonMarker:)    forControlEvent:GXGesturedButtonEventSwipeLeft];

        [opLifeButton addAction:@selector(addOpPoisonMarker:)       forControlEvent:GXGesturedButtonEventSwipeRight];
        [opLifeButton addAction:@selector(removeOpPoisonMarker:)    forControlEvent:GXGesturedButtonEventSwipeLeft];

        [myLifeRvButton addAction:@selector(addMyPoisonMarker:)     forControlEvent:GXGesturedButtonEventSwipeLeft];
        [myLifeRvButton addAction:@selector(removeMyPoisonMarker:)  forControlEvent:GXGesturedButtonEventSwipeRight];

        [opLifeRvButton addAction:@selector(addOpPoisonMarker:)     forControlEvent:GXGesturedButtonEventSwipeLeft];
        [opLifeRvButton addAction:@selector(removeOpPoisonMarker:)  forControlEvent:GXGesturedButtonEventSwipeRight];
    }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    
    // Seed the random.
    srand(time(NULL));
    
    myLifeRvView.transform = CGAffineTransformMakeRotation(M_PI);
    opLifeRvView.transform = CGAffineTransformMakeRotation(M_PI);
    
    myLifeRvLabel.transform = CGAffineTransformMakeRotation(M_PI);
    opLifeRvLabel.transform = CGAffineTransformMakeRotation(M_PI);

    myPoisonRvLabel.transform = CGAffineTransformMakeRotation(M_PI);
    opPoisonRvLabel.transform = CGAffineTransformMakeRotation(M_PI);

    [self addGestureActions];
    
    self.gameRunning = NO;
    [self resetGameState];
}


- (void)resetGameState {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:YGO_MODE_KEY]) {
        // YGO mode.
        self.myLife = 8000;
        self.opLife = 8000;
        lifeIncrement = 100;
        lifeIncrementLarge = 1000;
        gameInYgoMode = YES;
    }
    else {
        // Magic mode.
        self.myLife = 20;
        self.opLife = 20;
        lifeIncrement = 1;
        lifeIncrementLarge = 5;
        gameInYgoMode = NO;
    }
    
    self.myPoisonMarkers = 0;
    self.opPoisonMarkers = 0;

    self.startDate = [NSDate date];
    [self updateTimerView];
    
    // Some gestures don't have the same behaviour between Magic and YGO modes.
    [self addGestureActions];
}


// Start the game if it is not running.
- (void)checkGameStarted {
	
    if (!self.gameRunning) [self startStopGame];
}


// Tilt a view.
- (void)wiggleView:(UIView *)aView withIntensity:(CGFloat)intensity {
    
    CALayer *touchedLayer = [aView layer];
    CABasicAnimation *wiggleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    wiggleAnimation.duration = 0.05f;
    wiggleAnimation.repeatCount = 3;
    wiggleAnimation.autoreverses = YES;
    wiggleAnimation.fromValue = [NSValue valueWithCATransform3D:
                                 CATransform3DRotate(touchedLayer.transform, intensity, 0.0, 0.0, 1.0)];
    wiggleAnimation.toValue = [NSValue valueWithCATransform3D:
                               CATransform3DRotate(touchedLayer.transform, -intensity, 0.0, 0.0, 1.0)];
    [touchedLayer addAnimation:wiggleAnimation forKey:@"wiggle"];    
}


#pragma mark -
#pragma mark - Life Mgt


- (IBAction)increaseMyLife:(id)sender {
    [self checkGameStarted];
    self.myLife += lifeIncrement;
}

- (IBAction)decreaseMyLife:(id)sender {
    [self checkGameStarted];
    self.myLife -= lifeIncrement;
}

- (IBAction)increaseMyLifeLarge:(id)sender {
    [self checkGameStarted];
    self.myLife += lifeIncrementLarge;
}

- (IBAction)decreaseMyLifeLarge:(id)sender {
    [self checkGameStarted];
    self.myLife -= lifeIncrementLarge;
}

- (IBAction)doubleMyLife:(id)sender {
    [self checkGameStarted];
    self.myLife *= 2;
}

- (IBAction)halveMyLife:(id)sender {
    [self checkGameStarted];
    self.myLife /= 2;
}

- (IBAction)customizeMyLife:(NSInteger)life {
    [self checkGameStarted];
    self.myLife = life;
}


- (IBAction)addMyPoisonMarker:(id)sender {
    [self checkGameStarted];
    if (self.myPoisonMarkers < 10) self.myPoisonMarkers++;
}

- (IBAction)removeMyPoisonMarker:(id)sender {
    [self checkGameStarted];
    if (self.myPoisonMarkers > 0) self.myPoisonMarkers--;
}


- (IBAction)increaseOpLife:(id)sender {
    [self checkGameStarted];
    self.opLife += lifeIncrement;
}

- (IBAction)decreaseOpLife:(id)sender {
    [self checkGameStarted];
    self.opLife -= lifeIncrement;
}

- (IBAction)increaseOpLifeLarge:(id)sender {
    [self checkGameStarted];
    self.opLife += lifeIncrementLarge;
}

- (IBAction)decreaseOpLifeLarge:(id)sender {
    [self checkGameStarted];
    self.opLife -= lifeIncrementLarge;
}

- (IBAction)doubleOpLife:(id)sender {
    [self checkGameStarted];
    self.opLife *= 2;
}

- (IBAction)halveOpLife:(id)sender {
    [self checkGameStarted];
    self.opLife /= 2;
}

- (IBAction)customizeOpLife:(NSInteger)life {
    [self checkGameStarted];
    self.opLife = life;
}


- (IBAction)addOpPoisonMarker:(id)sender {
    [self checkGameStarted];
    if (self.opPoisonMarkers < 10) self.opPoisonMarkers++;
}

- (IBAction)removeOpPoisonMarker:(id)sender {
    [self checkGameStarted];
    if (self.opPoisonMarkers > 0) self.opPoisonMarkers--;
}


// Setup the life property and update the user interface.
- (void)setMyLife:(NSInteger)life {
    
    CGFloat intensity = 0.1;
    [self wiggleView:myLifeRvView withIntensity:intensity];
    [self wiggleView:myLifeView withIntensity:intensity];
    
    myLife = life;
	myLifeView.text = [NSString stringWithFormat:@"%d", myLife];
	myLifeRvView.text = [NSString stringWithFormat:@"%d", myLife];
}


// Setup the life property and update the user interface.
- (void)setOpLife:(NSInteger)life {
    
    CGFloat intensity = 0.1;
    [self wiggleView:opLifeRvView withIntensity:intensity];
    [self wiggleView:opLifeView withIntensity:intensity];

    opLife = life;
	opLifeView.text = [NSString stringWithFormat:@"%d", opLife];
	opLifeRvView.text = [NSString stringWithFormat:@"%d", opLife];
}


// Convert a number of poison markers into a string of dots.
NSString *poisonCounterToDots(NSUInteger counter) {
    
    NSString *dotString = @"";
    
    for (NSUInteger i = 0; i < counter; i++) {
        
        if (i == 5) dotString = [dotString stringByAppendingString:@" "];
        dotString = [dotString stringByAppendingString:@"•"];
    }
    
    return dotString;
}


// Setup the poison markers property and update the user interface.
- (void)setMyPoisonMarkers:(NSUInteger)poisonMarkers {
    
    CGFloat intensity = 0.1;
    [self wiggleView:myPoisonLabel withIntensity:intensity];
    [self wiggleView:myPoisonRvLabel withIntensity:intensity];
    
    myPoisonMarkers = poisonMarkers;
	myPoisonLabel.text = poisonCounterToDots(self.myPoisonMarkers);
	myPoisonRvLabel.text = poisonCounterToDots(self.myPoisonMarkers);
}


// Setup the poison markers property and update the user interface.
- (void)setOpPoisonMarkers:(NSUInteger)poisonMarkers {
    
    CGFloat intensity = 0.1;
    [self wiggleView:opPoisonLabel withIntensity:intensity];
    [self wiggleView:opPoisonRvLabel withIntensity:intensity];
    
    opPoisonMarkers = poisonMarkers;
	opPoisonLabel.text = poisonCounterToDots(self.opPoisonMarkers);
	opPoisonRvLabel.text = poisonCounterToDots(self.opPoisonMarkers);
}


#pragma mark -
#pragma mark - Start Stop


// Warn the user if he really wants to reset the score, and reset the life counters
// and the time counter.
- (IBAction)startStopGame {

    if (self.gameRunning) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"End the current game?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
        
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }
    else {
        
        self.gameRunning = YES;
	}
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

	// The user clicked the OK button.
	if (buttonIndex == 0)
	{
        self.gameRunning = NO;
	}
}


// Set the property, update the user interface launch the time counter and
// prevent the device from going to sleep mode, if the game is running.
- (void)setGameRunning:(BOOL)running {
        
	gameRunning = running;
    
    if (gameRunning) {
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        //[self.startStopButton setTitle:@"Stop Game" forState:UIControlStateNormal];
        self.startDate = [NSDate date];
    }
    else {
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        [self.startStopButton setTitle:@"Start Game" forState:UIControlStateNormal];
        [self resetGameState];
    }

    [self setTimerRunning:gameRunning];
    CGFloat intensity = 0.1;
    [self wiggleView:startStopButton withIntensity:intensity];
}


// Launches a dice (between 0 and 6) and displays its result as an alert view.
- (IBAction)launchDice:(id)sender {
    
    NSString *diceResultMessage = [NSString stringWithFormat:@"Dice result %d.", 1 + rand() % 6];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rolling Dice"
                                                    message:diceResultMessage
                                                   delegate:self
                                          cancelButtonTitle:@"Thanks"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


#pragma mark -
#pragma mark - Timer Mgt


- (void)setTimerRunning:(BOOL)running {

    if (running) {
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                                      target:self
                                                    selector:@selector(updateTimerView)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    else {
        [self.timer invalidate];
        // Release the timer.
        self.timer = nil;
    }

}


- (void)updateTimerView {

    NSTimeInterval playTime = -[self.startDate timeIntervalSinceNow];
    NSString *timeString = @"Time: ";
    
    int h = (int)(playTime / 3600);
    int m = (int)(playTime / 60) - h * 60;
	int s = (int)playTime - h * 3600 - m * 60;

    if (h > 0) {
        timeString = [timeString stringByAppendingFormat:@"%dh%02d'%02d\"", h, m, s];
    }
    else {
        timeString = [timeString stringByAppendingFormat:@"%d'%02d\"", m, s];
    }
    
    if (self.gameRunning) [startStopButton setTitle:timeString forState:UIControlStateNormal];
}


#pragma mark -
#pragma mark - Custom Score View Ctlr


- (IBAction)showCustomScoreView:(id)sender {
    
    // Configure the labels with the current scores.
    customScoreMyTextField.text = [NSString stringWithFormat:@"%d", myLife];
    customScoreOpTextField.text = [NSString stringWithFormat:@"%d", opLife];
    
    // Show the view, with a dissolve animation.
    customScoreView.alpha = 0.0;
    [self.view addSubview:customScoreView];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    customScoreView.alpha = 1.0;
    [UIView commitAnimations];
}


- (IBAction)showCustomMyScoreView:(id)sender {
    
    [self showCustomScoreView:self];
    [customScoreMyTextField becomeFirstResponder];
}


- (IBAction)showCustomOpScoreView:(id)sender {
    
    [self showCustomScoreView:self];
    [customScoreOpTextField becomeFirstResponder];
}


- (IBAction)hideCustomScoreView:(id)sender {
    
    // Hide the keyboard.
    [customScoreMyTextField resignFirstResponder];
    [customScoreOpTextField resignFirstResponder];
    
    // Hide the view, with a dissolve animation.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:customScoreView];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    customScoreView.alpha = 0.0;
    [UIView commitAnimations];
}


- (IBAction)validateCustomScoreView:(id)sender {

    // Set the new scores, if different (to avoid the labels to wiggle).
    NSInteger myLifeNew= [customScoreMyTextField.text integerValue];
    if (myLifeNew != self.myLife) [self customizeMyLife:myLifeNew];
    
    NSInteger opLifeNew = [customScoreOpTextField.text integerValue];
    if (opLifeNew != self.opLife) [self customizeOpLife:opLifeNew];
    
    [self hideCustomScoreView:self];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self validateCustomScoreView:self];    
	return NO;
}


#pragma mark -
#pragma mark - Info Panel


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
    // If the game mode configuration changed, reset the game state.
    if (gameInYgoMode != [[NSUserDefaults standardUserDefaults] boolForKey:YGO_MODE_KEY]) {
		self.gameRunning = NO;
    }
    
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark - Memory


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [myPoisonLabel release];
    
    [timer release];
    [startDate release];
    
    [startStopButton release];
    [timerButton release];
    
    [myLifeView release];
    [opLifeView release];
    [myLifeRvView release];
    [opLifeRvView release];
    [myLifeRvLabel release];
    [opLifeRvLabel release];
    [myLifeButton release];
    
    [customScoreView release];
    [customScoreMyTextField release];
    [customScoreOpTextField release];

    [opPoisonRvLabel release];
    [myPoisonRvLabel release];
    [opPoisonLabel release];
    [super dealloc];
}


- (void)viewDidUnload {
    [self setMyPoisonLabel:nil];
    [self setOpPoisonRvLabel:nil];
    [self setMyPoisonRvLabel:nil];
    [self setOpPoisonLabel:nil];
    [super viewDidUnload];
}
@end
