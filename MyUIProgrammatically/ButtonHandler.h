//
//  ButtonHandler.h
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/20/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoolButton.h"


@interface ButtonHandler : NSObject

- (CoolButton *)createStartButton;

- (void)addScaleAnimationToButton:(CoolButton *)button;

- (CoolButton *)createResetButton;

@end
