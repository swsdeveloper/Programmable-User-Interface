//
//  ViewController.m
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/16/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import "MyViewController.h"
#import "Constants.h"
#import "AudioHandler.h"
#import "ButtonHandler.h"


@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Program will start in the orientation last set on the simulator. So end each test with Simulator in Portrait mode.
    
    // The bounds of a UIView is the rectangle relative to its own coordinate system (0,0).
    // The frame  of a UIView is the rectangle relative to the superview it is contained within.
    
    // *** The view automatically fills the window's frame  (self.view.bounds = [[UIScreen mainScreen] bounds];)
    
    if (MYDEBUG) {
        CGFloat boundsX = self.view.bounds.origin.x;     // CGFloat -> float
        CGFloat boundsY = self.view.bounds.origin.x;
        CGFloat boundsWidth = self.view.bounds.size.width;
        CGFloat boundsHeight = self.view.bounds.size.height;
        
        CGFloat frameX = self.view.frame.origin.x;     // CGFloat -> float
        CGFloat frameY = self.view.frame.origin.x;
        CGFloat frameWidth = self.view.frame.size.width;
        CGFloat frameHeight = self.view.frame.size.height;
        
        NSLog(@"View  Bounds: x:%f, y:%f, w:%f, h:%f", boundsX, boundsY, boundsWidth, boundsHeight);  // 0, 0, 768, 1024  (iPad Air)
        NSLog(@"View  Frame : x:%f, y:%f, w:%f, h:%f", frameX, frameY, frameWidth, frameHeight);      // same
        
        //self.view.alpha = 0.0;  // un-comment this to see the window's color
    }
    
    numberOfPositions = 9;      // Number of box positions we support (see position enum in *.h)
    
    countRotations = 0;         // We will auto swap all current photos on every 4th rotation
        
    [self setUpAudioPlayers];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    if (!self.startButton) {
        ButtonHandler *myButtonHandler = [[ButtonHandler alloc] init];
        
        self.startButton = [myButtonHandler createStartButton];
        
        [self.startButton addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.startButton];
        
        [self performSelector:@selector(makeStartButtonFlash) withObject:self afterDelay:5.0];    // delay 5 seconds
    }
}

- (void)displayDeviceOrientation {
    
    if (!self.orientationLabel) {
        return;
    }
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (iOrientation) {
        case UIInterfaceOrientationPortrait:
            self.orientationLabel.text = @"Portrait";
            break;
        case UIInterfaceOrientationLandscapeLeft:
            self.orientationLabel.text = @"Landscape Left";
            break;
        case UIInterfaceOrientationLandscapeRight:
            self.orientationLabel.text = @"Landscape Right";
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            self.orientationLabel.text = @"Portrait Upside Down";
            break;
        default:
            self.orientationLabel.text = @"Unknown Device Orientation";
            break;
    }
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat labelWidth = self.orientationLabel.frame.size.width;
    CGFloat labelHeight = self.orientationLabel.frame.size.height;
    
    // Label should be positioned between bottom of upperMiddle box [1] and top of center box [4]
    
    Box *box1 = self.boxes[1];
    Box *box4 = self.boxes[4];
    
    CGFloat box1Bottom = box1.frame.origin.y + box1.frame.size.height;
    CGFloat box4Top = box4.frame.origin.y;
    CGFloat labelX = (viewWidth - labelWidth) / 2.0;
    CGFloat labelY = box1Bottom + ((box4Top - box1Bottom - labelHeight) * 0.5);
    
    self.orientationLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    // NSLog(@"\nbox1Bottom: %f, box4Top: %f, box1Y: %f, box1H: %f", box1Bottom, box4Top, box1.frame.origin.y, box1.frame.size.height);
    // NSLog(@"Label: x:%f, y:%f, w:%f, h:%f, %@", labelX, labelY, labelWidth, labelHeight, self.orientationLabel.text);
    
    // Reset Button should be positioned between bottom of center box [4] and top of lowerMiddle box [7]
    
    CGFloat buttonWidth = self.resetButton.frame.size.width;
    CGFloat buttonHeight = self.resetButton.frame.size.height;
    
    Box *box7 = self.boxes[7];
    
    CGFloat box4Bottom = box4.frame.origin.y + box4.frame.size.height;
    CGFloat box7Top = box7.frame.origin.y;
    CGFloat buttonX = (viewWidth - buttonWidth) / 2.0;
    CGFloat buttonY = box4Bottom + ((box7Top - box4Bottom - buttonHeight) * 0.5);
    
    self.resetButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
}

// Called whenever view appears and whenever screen rotates
- (void)viewWillLayoutSubviews {
    
    self.startButton.center = self.view.center;     // Center button in middle of frame
    
    [self positionAllBoxes];
    
    [self displayDeviceOrientation];
}

// As of iOS8 - the following method replaces willRotateToInterfaceOrientation:duration:
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self.audioPlayer2 play];   // Sound is played asynchronously (so no need to launch separate thread)
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    countRotations++;
    
    if (countRotations > 3) {
        [self changeImagesInAllBoxes];
        countRotations = 0;
    }
}

- (void)positionAllBoxes {
    int i = upperLeft; // use i to enumerate through all possible positions. There are as many boxes as there are different positions to put them in.

    for (Box *box in self.boxes) {
        [self positionBox:box atPos:i++];
    }
}

- (void)changeImagesInAllBoxes {
    
    for (Box *box in self.boxes) {
        [box changeImage];
    }
}

- (void)positionBox:(Box *)box atPos:(enum position)pos {
    
    if (pos == center) {
        box.center = self.view.center;
        return;
    }
    
    // Position boxes (regardless of orientation); don't change box size
    
    CGFloat boxX = 0.0;
    CGFloat boxY = 0.0;
    CGFloat boxWidth = box.frame.size.width;
    CGFloat boxHeight = box.frame.size.height;
    
    // NSLog(@"\nPositioning box: w:%f, h:%f", boxWidth, boxHeight);
    
    // (Re-)set X and Y origin point
    
    CGFloat frameX = self.view.frame.origin.x;
    CGFloat frameY = self.view.frame.origin.y;
    CGFloat frameWidth = self.view.frame.size.width;
    CGFloat frameHeight = self.view.frame.size.height;
    
    // NSLog(@"Getting frame: w:%f, h:%f", frameWidth, frameHeight);
    
    CGFloat marginOffset = 0.0;
    
    CGPoint lowerRightOrigin = {frameWidth - boxWidth - marginOffset, frameHeight - boxHeight - marginOffset};
    CGPoint lowerMiddleOrigin = {((frameWidth - boxWidth)/2.0) - marginOffset, lowerRightOrigin.y};
    CGPoint lowerLeftOrigin = {frameX + marginOffset, lowerRightOrigin.y};
    
    CGPoint upperRightOrigin = {lowerRightOrigin.x, frameY + marginOffset};
    CGPoint upperMiddleOrigin = {lowerMiddleOrigin.x, upperRightOrigin.y};
    CGPoint upperLeftOrigin = {lowerLeftOrigin.x, upperRightOrigin.y};
    
    CGPoint middleRightOrigin = {lowerRightOrigin.x, ((frameHeight - boxHeight)/2.0) - marginOffset};
    CGPoint middleLeftOrigin = {lowerLeftOrigin.x, middleRightOrigin.y};
    
    switch (pos) {
        case upperLeft:
            boxX = upperLeftOrigin.x;
            boxY = upperLeftOrigin.y;
            break;
        case upperMiddle:
            boxX = upperMiddleOrigin.x;
            boxY = upperMiddleOrigin.y;
            break;
        case upperRight:
            boxX = upperRightOrigin.x;
            boxY = upperRightOrigin.y;
            break;
        case middleLeft:
            boxX = middleLeftOrigin.x;
            boxY = middleLeftOrigin.y;
            break;
        case center:    // handled above, should never get here
            break;
        case middleRight:
            boxX = middleRightOrigin.x;
            boxY = middleRightOrigin.y;
            break;
        case lowerLeft:
            boxX = lowerLeftOrigin.x;
            boxY = lowerLeftOrigin.y;
            break;
        case lowerMiddle:
            boxX = lowerMiddleOrigin.x;
            boxY = lowerMiddleOrigin.y;
            break;
        case lowerRight:
            boxX = lowerRightOrigin.x;
            boxY = lowerRightOrigin.y;
            break;
        default:
            break;
    }
    
    // NSLog(@"Frame of Box: x:%f, y:%f, w:%f, h:%f", boxX, boxY, boxWidth, boxHeight);
    
    box.frame = CGRectMake(boxX, boxY, boxWidth, boxHeight);
}

- (void)makeStartButtonFlash {
    if (self.startButton) {
        
        ButtonHandler *myButtonHandler = [[ButtonHandler alloc] init];
        
        [myButtonHandler addScaleAnimationToButton:self.startButton];
        
        [self performSelector:@selector(makeStartButtonFlash) withObject:self afterDelay:3.0];    // delay 3 seconds
    }
}

- (IBAction)startButtonPressed:(id)sender  {
    
    [self.startButton removeFromSuperview];   // Get rid of start button
    
    if (self.audioPlayer1) {
        [self.audioPlayer1 play];
    }
        
    self.boxes = [[NSMutableArray alloc] initWithCapacity:numberOfPositions];
    
    [self generateBoxes];
    
    for (Box *box in self.boxes) {
        [self.view addSubview:box];
    }
    
    [self createDeviceOrientationLabel];
    
    if (!self.resetButton) {
        ButtonHandler *myButtonHandler = [[ButtonHandler alloc] init];
        
        self.resetButton = [myButtonHandler createResetButton];
        
        [self.resetButton addTarget:self action:@selector(resetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:self.resetButton];
    }
}

- (IBAction)resetButtonPressed:(id)sender  {
    
    if (self.audioPlayer3) {
        [self.audioPlayer3 play];
    }
    
    countRotations = 0;
    
    for (Box *box in self.boxes) {
        [box removeFromSuperview];
    }
    
    [self generateBoxes];
    
    for (Box *box in self.boxes) {
        [self.view addSubview:box];
    }
}

- (void)generateBoxes {
    
    for (int i=0; i < numberOfPositions; i++) {
        self.boxes[i] = [[Box alloc] initWithSize:[self genRandomBoxSize]];
    }
    
    // Replace the above for loop with the following stmts - for controlled size testing:
    //
    //    self.boxes[0] = [[Box alloc] initWithSize:200.0];
    //    self.boxes[1] = [[Box alloc] initWithSize:150.0];
    //    self.boxes[2] = [[Box alloc] initWithSize:180.0];
    //    self.boxes[3] = [[Box alloc] initWithSize:225.0];
    //    self.boxes[4] = [[Box alloc] initWithSize:300.0];
    //    self.boxes[5] = [[Box alloc] initWithSize:100.0];
    //    self.boxes[6] = [[Box alloc] initWithSize:250.0];
    //    self.boxes[7] = [[Box alloc] initWithSize:125.0];
    //    self.boxes[8] = [[Box alloc] initWithSize:80.0];
    
    // NSLog(@"boxes[0] frame: w:%f, h:%f", self.boxes[0].frame.size.width, self.boxes[0].frame.size.height);
    
    // Boxes have no position when created. Positions are set in viewWillLayoutSubviews
}

- (void)createDeviceOrientationLabel {
    // Set up Device Orientation Label (origin will be set when orientation is determined)
    
    CGFloat labelWidth = self.view.frame.size.width;
    CGFloat labelHeight = 50;
    
    self.orientationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, labelWidth, labelHeight)];
    self.orientationLabel.textAlignment = NSTextAlignmentCenter;
    self.orientationLabel.textColor = [UIColor blackColor];
    self.orientationLabel.text = @"";
    
    // Apple's Built-In Fonts List for iOS7: http://support.apple.com/en-us/HT202771
    
    self.orientationLabel.font = [UIFont fontWithName:@"Baskerville-Bold" size:30];
    
    [self.view addSubview:self.orientationLabel];
}

- (CGFloat)genRandomBoxSize {
    int maxSize = (self.view.frame.size.width < self.view.frame.size.height) ? (int)(self.view.frame.size.width / 3.0) : (int)(self.view.frame.size.height / 3.0);
    int minSize = (self.view.frame.size.width < self.view.frame.size.height) ? (int)(self.view.frame.size.width / 4.0) : (int)(self.view.frame.size.height / 4.0);
    CGFloat boxSize = (CGFloat)arc4random_uniform((maxSize-minSize)+1) + minSize;    // return size between min and max (eg: arc4random_uniform(271)+80 -> 80-350)
    // NSLog(@"boxSize = %f", boxSize);
    return boxSize;
}

- (void)setUpAudioPlayers {
    AudioHandler *myAudioHandler = [[AudioHandler alloc] init];
    self.audioPlayer1 = [myAudioHandler setupAudioPlayer1];
    self.audioPlayer2 = [myAudioHandler setupAudioPlayer2];
    self.audioPlayer3 = [myAudioHandler setupAudioPlayer3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
