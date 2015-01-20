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

@implementation Box

- (id)initWithSize:(CGFloat)size {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self createBoxOfSize:size];
    
    return self;
}

- (Box *)createBoxOfSize:(CGFloat)size {

    // Create a box of the specified size, but don't position it, yet
    
    self.frame = CGRectMake(0, 0, size, size);
    
    // NSLog(@"Create box frame: w:%f, h:%f", size, size);
    
    // *** Create a sublayer to hold an image
    
    [self randomlyPickAnImage];     // sets self.image
    
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
    //return;
    
    NSArray *sublayers = [self.layer sublayers];
    NSUInteger numberOfSubLayers = [sublayers count];
    if (numberOfSubLayers > 0) {
        int i = (int)numberOfSubLayers - 1;
        CALayer *oldLayer = sublayers[i];
        CALayer *newLayer = oldLayer;
        [self randomlyPickAnImage];     // sets self.image
        newLayer.contents = (id)self.image.CGImage;
        [self.layer replaceSublayer:oldLayer with:newLayer];
    }
    [self setNeedsDisplay];
}

- (void)randomlyPickAnImage {
    switch (arc4random_uniform(17)) {
        case 0:
            self.image = [UIImage imageNamed:@"Bayon.JPG"];
            break;
        case 1:
            self.image = [UIImage imageNamed:@"Dancers.JPG"];
            break;
        case 2:
            self.image = [UIImage imageNamed:@"Flutes.JPG"];
            break;
        case 3:
            self.image = [UIImage imageNamed:@"Kids.JPG"];
            break;
        case 4:
            self.image = [UIImage imageNamed:@"Marjorie.JPG"];
            break;
        case 5:
            self.image = [UIImage imageNamed:@"Monkey.JPG"];
            break;
        case 6:
            self.image = [UIImage imageNamed:@"Monks.JPG"];
            break;
        case 7:
            self.image = [UIImage imageNamed:@"Shiva.JPG"];
            break;
        case 8:
            self.image = [UIImage imageNamed:@"Angkor.jpg"];
            break;
        case 9:
            self.image = [UIImage imageNamed:@"Einstein.jpg"];
            break;
        case 10:
            self.image = [UIImage imageNamed:@"Balloon.jpg"];
            break;
        case 11:
            self.image = [UIImage imageNamed:@"Lemon.png"];
            break;
        case 12:
            self.image = [UIImage imageNamed:@"LionCub.jpg"];
            break;
        case 13:
            self.image = [UIImage imageNamed:@"Tiger.jpg"];
            break;
        case 14:
            self.image = [UIImage imageNamed:@"Tiger2.jpg"];
            break;
        case 15:
            self.image = [UIImage imageNamed:@"SWS.jpg"];
            break;
       default:
            self.image = [UIImage imageNamed:@"SWS.png"];
    }
}

//- (void)getRandomImageFromCameraRoll {
//    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
//    
//    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
//                                 usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//                                     if (nil != group) {
//                                         // be sure to filter the group so you only get photos
//                                         [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//                                         
//                                         
//                                         [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:group.numberOfAssets - 1]
//                                                                 options:0
//                                                              usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                                                                  if (nil != result) {
//                                                                      ALAssetRepresentation *repr = [result defaultRepresentation];
//                                                                      // this is the most recent saved photo
//                                                                      UIImage *img = [UIImage imageWithCGImage:[repr fullResolutionImage]];
//                                                                      // we only need the first (most recent) photo -- stop the enumeration
//                                                                      *stop = YES;
//                                                                  }
//                                                              }];
//                                     }
//                                     
//                                     *stop = NO;
//                                 } failureBlock:^(NSError *error) {
//                                     NSLog(@"error: %@", error);
//                                 }];
//}

@end
