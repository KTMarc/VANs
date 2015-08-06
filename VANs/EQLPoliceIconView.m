//
//  EQLPoliceIconView.m
//  VAN Selector
//
//  Created by Marc Humet on 5/8/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLPoliceIconView.h"

IB_DESIGNABLE
IBInspectable


@implementation EQLPoliceIconView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    [VanStyleKit drawPoliceIconWithColorParameter:[UIColor whiteColor]];
}


@end
