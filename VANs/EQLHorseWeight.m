//
//  EQLHorseWeight.m
//  VAN Selector
//
//  Created by Marc Humet on 29/10/15.
//  Copyright © 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLHorseWeight.h"

IB_DESIGNABLE

@implementation EQLHorseWeight


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [VanStyleKit drawMaxHorseWeightWithFrame:self.bounds];
}


@end
