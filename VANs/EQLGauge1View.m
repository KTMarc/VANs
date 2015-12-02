//
//  EQLGauge1Control.m
//  VAN Selector
//
//  Created by Marc Humet on 22/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLGauge1View.h"


@implementation EQLGauge1View

+(Class)layerClass {
    return [EQLGauge1Layer class];
}

-(void)setPercentage:(CGFloat)percentage {
    _percentage = percentage;
    ((EQLGauge1Layer*)self.layer).percentage = percentage;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        
        self.layer.needsDisplayOnBoundsChange = YES;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

@end
