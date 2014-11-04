//
//  EQLsuspensionIcon.m
//  VAN Selector
//
//  Created by Marc Humet on 4/11/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLsuspensionIcon.h"

@implementation EQLsuspensionIcon


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [VanStyleKit drawSuspensionPullmanWithVisibleSuspension:_suspension];
}


@end
