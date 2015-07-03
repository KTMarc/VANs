//
//  EQLGauge1ControlLayer.m
//  VAN Selector
//
//  Created by Marc Humet on 22/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLGauge1Layer.h"


@implementation EQLGauge1Layer


@dynamic percentage;

+(BOOL)needsDisplayForKey:(NSString*)key {
    if ([key isEqualToString:@"percentage"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

-(CABasicAnimation *)makeAnimationForKey:(NSString *)key {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:key];
    anim.fromValue = [[self presentationLayer] valueForKey:key];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.duration = [CATransaction animationDuration];
    
    return anim;
}

-(id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"percentage"]) {
        return [self makeAnimationForKey:event];
    } else {
        return [super actionForKey:event];
    }
}

-(void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    UIGraphicsPushContext(ctx);
    
   // [VanStyleKit drawGaugeWithPressure:self.percentage];
    
    UIGraphicsPopContext();
}
@end