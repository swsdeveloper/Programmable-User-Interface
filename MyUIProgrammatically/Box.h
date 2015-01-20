//
//  Box.h
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/17/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Box : UIView

@property (strong, nonatomic) UIImage *image;

- (id)initWithSize:(CGFloat)size;

- (Box *)createBoxOfSize:(CGFloat)size;

- (void)changeImage;

@end
