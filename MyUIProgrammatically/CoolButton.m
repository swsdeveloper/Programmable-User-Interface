//
//  CoolButton.m
//  CoolButton - Ray Wenderlich Tutorial: http://www.raywenderlich.com/33330/core-graphics-tutorial-glossy-buttons
//
//  Created by Steven Shatz on 1/18/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import "CoolButton.h"
#import "RayWCommon.h"


@implementation CoolButton

- (id)init {
    self = [super init];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
    }
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIColor *color = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:1.0];
//    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextFillRect(context, self.bounds);
//}

- (void)drawRect:(CGRect)rect {
    /*
     1. First you set up a bunch of colors that you’ll use later. There are a few generic colors ...
     2. .. and several colors based on the passed in parameters. Your base color is exactly how you’re set up, then you have several colors set up to be darker than the current color, to varying degrees.
     3. Set up an outer path using CGRectInset to get a slightly smaller rectangle (5 pixels on each side) where you’ll draw the rounded rect. You make it smaller so you have space to draw a shadow on the outside. (Call the function in Common.m to create a path for your rounded rect.)
     4. Now add an inner path that has a slightly different gradient than the outer path, to create a bevel-type effect.
     5. Now add a very subtle highlight on the top, if the button is selected. You’re basically creating another rounded rect slightly smaller than the outerRect, and filling the area between the two rectangles with an alpha highlight gradient, using the Even-Odd Clip technique
     6. You then set the outer path's fill color and shadow, add the path to your context, and call CGContextFillPath to fill it with your current color.
     7. Then stroke the outer path with black (2 points to avoid the 1px issues), and the inner path with a 1 point stroke. “OMGBBQ”, you may say, “that is a 2 point stroke, not a 1 point stroke!” Well, you’re using a different technique to solve the 1px issue here – the “clipping mask” technique referred to earlier. Basically you set the stroke to be 2 points, and then clip off the outside region.
     8. At the end, you release the paths you’ve created.
     
        Note you only want to run the code if your button isn’t currently highlighted (i.e. being tapped upon).
     */
    
    CGFloat actualBrightness = self.brightness;     // Reduce brightness slightly while button is pressed
    if (self.state == UIControlStateHighlighted) {
        actualBrightness -= 0.20;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];                                                  // 1.
    UIColor *highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    UIColor *highlightStop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    UIColor *shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    UIColor *outerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0*actualBrightness alpha:1.0];       // 2.
    UIColor *outerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.80*actualBrightness alpha:1.0];
    UIColor *innerStroke = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.80*actualBrightness alpha:1.0];
    UIColor *innerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.90*actualBrightness alpha:1.0];
    UIColor *innerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.70*actualBrightness alpha:1.0];
    
    CGFloat outerMargin = 5.0f;                                                                                                     // 3A.
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 10.0);
    
    CGFloat innerMargin = 3.0f;                                                                                                     // 4A.
    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 10.0);
    
    CGFloat highlightMargin = 2.0f;                                                                                                 // 5A.
    CGRect highlightRect = CGRectInset(outerRect, highlightMargin, highlightMargin);
    CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, 10.0);
    
    if (self.state != UIControlStateHighlighted) {                                                                                  // 6.
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, outerTop.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
        CGContextAddPath(context, outerPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);                                                                                                   // 3B.
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    drawGlossAndGradient(context, outerRect, outerTop.CGColor, outerBottom.CGColor);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);                                                                                                   // 4B.
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    drawGlossAndGradient(context, innerRect, innerTop.CGColor, innerBottom.CGColor);
    CGContextRestoreGState(context);
    
    if (self.state != UIControlStateHighlighted) {                                                                                  // 5B.
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 4.0);
        CGContextAddPath(context, outerPath);
        CGContextAddPath(context, highlightPath);
        CGContextEOClip(context);
        drawLinearGradient(context, outerRect, highlightStart.CGColor, highlightStop.CGColor);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);                                                                                                   // 7A.
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);                                                                                                   // 7B.
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, innerStroke.CGColor);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    CGContextAddPath(context, innerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);                                                                                                           // 8.
    CFRelease(innerPath);
    CFRelease(highlightPath);
}


// Set color aspects when sliders are moved

- (void)setHue:(CGFloat)hue {
    _hue = hue;
    [self setNeedsDisplay];
}

- (void)setSaturation:(CGFloat)saturation {
    _saturation = saturation;
    [self setNeedsDisplay];
}

- (void)setBrightness:(CGFloat)brightness {
    _brightness = brightness;
    [self setNeedsDisplay];
}


// Code to animate pressing of button

- (void)hesitateUpdate {
    //NSLog(@"Hue:%f, Saturation:%f, Brightness: %f", self.hue, self.saturation, self.brightness);
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

// Apple's Quartz 2D Programming Guide:
// https://developer.apple.com/library/ios/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_context/dq_context.html

// CGContextAddArcToPoint API lets you specify the arc to draw by specifying two tangent lines and a radius


@end
