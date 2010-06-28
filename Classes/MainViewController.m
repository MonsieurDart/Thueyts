//
//  MainViewController.m
//  Thueyts
//
//  Created by Mathieu Godart on 21/06/10.
//  Copyright Coolsand 2010. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/CAAnimation.h>


@implementation MainViewController


@synthesize gameRunning, timer, startDate;
@synthesize startStopButton, timerButton;
@synthesize myLife, myLifeView, myLifeRvView, myLifeRvLabel;
@synthesize opLife, opLifeView, opLifeRvView, opLifeRvLabel;


#pragma mark -
#pragma mark - View Setup


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.myLifeRvView.transform = CGAffineTransformMakeRotation(M_PI);
    self.opLifeRvView.transform = CGAffineTransformMakeRotation(M_PI);
    
    self.myLifeRvLabel.transform = CGAffineTransformMakeRotation(M_PI);
    self.opLifeRvLabel.transform = CGAffineTransformMakeRotation(M_PI);
    
    self.gameRunning = NO;
    [self resetGameState];
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)resetGameState {
    
    self.myLife = 20;
    self.opLife = 20;
    self.startDate = [NSDate date];
    [self updateTimerView];
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
    if (!self.gameRunning) [self startStopGame];
	self.myLife++;
}


- (IBAction)increaseOpLife:(id)sender {
    if (!self.gameRunning) [self startStopGame];
	self.opLife++;
}


- (IBAction)decreaseMyLife:(id)sender {
    if (!self.gameRunning) [self startStopGame];
	self.myLife--;
}


- (IBAction)decreaseOpLife:(id)sender {
    if (!self.gameRunning) [self startStopGame];
	self.opLife--;
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
    
    if (running == gameRunning) return;
    
	gameRunning = running;
    
    if (gameRunning) {
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        [self.startStopButton setTitle:@"Stop Game" forState:UIControlStateNormal];
        self.startDate = [NSDate date];
    }
    else {
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        [self.startStopButton setTitle:@"Start Game" forState:UIControlStateNormal];
        [self resetGameState];
    }

    [self setTimerRunning:gameRunning];
    CGFloat intensity = 0.1;
    //[self wiggleView:startStopButton withIntensity:intensity];
    [self wiggleView:timerButton withIntensity:intensity];
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
    
    [timerButton setTitle:timeString forState:UIControlStateNormal];
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
    
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark - Memory


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)dealloc {
    [super dealloc];
    
    [timer release];
    [startDate release];
    
    [startStopButton release];
    [timerButton release];
    
    [myLifeView release];
    [myLifeRvView release];
    [myLifeRvLabel release];
    [opLifeView release];
    [opLifeRvView release];
    [opLifeRvLabel release];
}


@end
