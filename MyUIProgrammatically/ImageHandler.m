//
//  ImageHandler.m
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/20/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import "ImageHandler.h"

@implementation ImageHandler

- (UIImage *)selectRandomImage {
    UIImage *image;

    switch (arc4random_uniform(17)) {
        case 0:
            image = [UIImage imageNamed:@"Bayon.JPG"];
            break;
        case 1:
            image = [UIImage imageNamed:@"Dancers.JPG"];
            break;
        case 2:
            image = [UIImage imageNamed:@"Flutes.JPG"];
            break;
        case 3:
            image = [UIImage imageNamed:@"Kids.JPG"];
            break;
        case 4:
            image = [UIImage imageNamed:@"Marjorie.JPG"];
            break;
        case 5:
            image = [UIImage imageNamed:@"Monkey.JPG"];
            break;
        case 6:
            image = [UIImage imageNamed:@"Monks.JPG"];
            break;
        case 7:
            image = [UIImage imageNamed:@"Shiva.JPG"];
            break;
        case 8:
            image = [UIImage imageNamed:@"Angkor.jpg"];
            break;
        case 9:
            image = [UIImage imageNamed:@"Einstein.jpg"];
            break;
        case 10:
            image = [UIImage imageNamed:@"Balloon.jpg"];
            break;
        case 11:
            image = [UIImage imageNamed:@"Lemon.png"];
            break;
        case 12:
            image = [UIImage imageNamed:@"LionCub.jpg"];
            break;
        case 13:
            image = [UIImage imageNamed:@"Tiger.jpg"];
            break;
        case 14:
            image = [UIImage imageNamed:@"Tiger2.jpg"];
            break;
        case 15:
            image = [UIImage imageNamed:@"SWS.jpg"];
            break;
        default:
            image = [UIImage imageNamed:@"SWS.png"];
    }
    return image;
}

@end
