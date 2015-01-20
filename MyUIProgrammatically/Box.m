//
//  Box.m
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/17/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import "Box.h"
#import "Constants.h"
#import <AVFoundation/AVFoundation.h>


// Create square box of specified size and insert a randomly selected image. Also supports changing to another random image

@implementation Box

- (id)initWithSize:(CGFloat)size {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.myImageHandler = [[ImageHandler alloc] init];

    [self createBoxOfSize:size];
    
    return self;
}

- (Box *)createBoxOfSize:(CGFloat)size {

    // Create a box of the specified size, but don't position it, yet
    
    self.frame = CGRectMake(0, 0, size, size);
    
    // NSLog(@"Create box frame: w:%f, h:%f", size, size);
    
    // *** Create a sublayer to hold an image
    
    self.image = [self.myImageHandler selectRandomImage];
    
    CALayer *sublayer = [CALayer layer];
    sublayer.frame = CGRectMake(self.frame.origin.x+2.0, self.frame.origin.y+2.0, self.frame.size.width-4.0, self.frame.size.height-4.0);
    sublayer.contents = (id)self.image.CGImage;
    sublayer.cornerRadius = 20.0;
    sublayer.masksToBounds = YES;
    sublayer.borderColor = [UIColor blackColor].CGColor;
    sublayer.borderWidth = 2.0;
    
//    sublayer.shadowOffset = CGSizeMake(-5.0, 5.0);
//    sublayer.shadowRadius = 5.0;
//    sublayer.shadowColor = [UIColor whiteColor].CGColor;
//    sublayer.shadowOpacity = 0.8;
    
    // NSLog(@"Create sublayer frame: w:%f, h:%f", sublayer.frame.size.width, sublayer.frame.size.height);
    
    sublayer.frame = CGRectInset(sublayer.frame, 20.0, 20.0);       // rect, dx, dy
    
    // *** Add the sublayer to the box's main layer
    
   [self.layer addSublayer:sublayer];
    
    return self;
}

- (void)changeImage {
    
    NSArray *sublayers = [self.layer sublayers];
    
    NSUInteger numberOfSubLayers = [sublayers count];
    
    if (numberOfSubLayers > 0) {
        int i = (int)numberOfSubLayers - 1;
        
        CALayer *oldLayer = sublayers[i];
        CALayer *newLayer = oldLayer;
        
        self.image = [self.myImageHandler selectRandomImage];
        
        newLayer.contents = (id)self.image.CGImage;
        
        [self.layer replaceSublayer:oldLayer with:newLayer];
    }
    [self setNeedsDisplay];
}

@end
