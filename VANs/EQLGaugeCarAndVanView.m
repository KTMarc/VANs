//
//  EQLGaugeCarAndVanView.m
//  VAN Selector
//
//  Created by Marc Humet on 14/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLGaugeCarAndVanView.h"

@implementation EQLGaugeCarAndVanView

-(id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.pressure = @20;
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
//    NSLog(@"we receive a new value:%@",self.pressure);
//    NSLog(@"And we transform it to:%f",[self.pressure floatValue]/1000);
    [VanStyleKit drawGaugeWithPressure:[self.pressure floatValue]/1000];

}

- (void)animatePath
{
    [EQLGaugeCarAndVanView animateWithDuration:2.0
     animations:^() {
         _pressure = @900;
         [self setNeedsDisplay];
     }];
}

@end
