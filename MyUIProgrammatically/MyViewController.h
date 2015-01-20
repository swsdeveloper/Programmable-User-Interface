//
//  ViewController.h
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/16/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Box.h"
#import "CoolButton.h"


@interface MyViewController : UIViewController {
    
    enum position {
        upperLeft,
        upperMiddle,
        upperRight,
        middleLeft,
        center,
        middleRight,
        lowerLeft,
        lowerMiddle,
        lowerRight
    };
    
    int numberOfPositions;
    
    int countRotations;
}

@property (strong, nonatomic) IBOutlet CoolButton *startButton;
@property (strong, nonatomic) IBOutlet CoolButton *resetButton;

@property (strong, nonatomic) UILabel *orientationLabel;

@property (strong, nonatomic) NSMutableArray *boxes;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer1;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer2;

@end

