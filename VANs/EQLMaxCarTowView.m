//
//  EQLMaxCarTowView.m
//  VAN Selector
//
//  Created by Marc Humet on 29/10/15.
//  Copyright © 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLMaxCarTowView.h"

IB_DESIGNABLE


@implementation EQLMaxCarTowView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

        [VanStyleKit drawMaxCarTowWithFrame:self.bounds];
}


@end
