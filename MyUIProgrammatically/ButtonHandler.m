//
//  ButtonHandler.m
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/20/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import "ButtonHandler.h"
#import <QuartzCore/QuartzCore.h>   // for CABasicAnimation

@implementation ButtonHandler

- (CoolButton *)createStartButton {
    
    // Create the button, but don't position it
    
    CoolButton *startButton = [[CoolButton alloc] init];
    
    startButton.frame = CGRectMake(0, 0, 200, 40); // set button's width (200) and height (40)
    
    startButton.hue = 0.625000;        // 0.625000 = navy blue; 0.837329 = magenta
    startButton.saturation = 1.000000;
    startButton.brightness = 1.000000;
    
    [startButton setTitle:@"Press Me" forState:UIControlStateNormal];
    
    return startButton;
}

- (CoolButton *)createResetButton {
    
    // Create the button, but don't position it
    
    CoolButton *resetButton = [[CoolButton alloc] init];
    
    resetButton.frame = CGRectMake(0, 0, 200, 40); // set button's width (200) and height (40)
    
    resetButton.hue = 0.837329;        // 0.625000 = navy blue; 0.837329 = magenta
    resetButton.saturation = 1.000000;
    resetButton.brightness = 1.000000;
    
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    
    return resetButton;
}

- (void)addScaleAnimationToButton:(CoolButton *)button {
    
    CABasicAnimation *theAnimation;
    
    //    theAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    theAnimation.duration = 0.1;
    theAnimation.repeatCount = 3;
    theAnimation.autoreverses = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    theAnimation.toValue = [NSNumber numberWithFloat:0.0];
    
    //    [button.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    [button.layer addAnimation:theAnimation forKey:@"animateTransform.scale"];
}

@end
