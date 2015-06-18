//
//  EQLGaugeCarAndVanView.m
//  VAN Selector
//
//  Created by Marc Humet on 14/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLGaugeCarAndVanView.h"

@implementation EQLGaugeCarAndVanView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [VanStyleKit drawGaugeWithPressure:0.81];
}

@end
