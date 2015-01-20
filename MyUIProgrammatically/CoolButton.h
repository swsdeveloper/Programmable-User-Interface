//
//  CoolButton.h
//  CoolButton - Ray Wenderlich Tutorial: http://www.raywenderlich.com/33330/core-graphics-tutorial-glossy-buttons
//
//  Created by Steven Shatz on 1/18/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolButton : UIButton

@property  (nonatomic, assign) CGFloat hue;
@property  (nonatomic, assign) CGFloat saturation;
@property  (nonatomic, assign) CGFloat brightness;

@end
