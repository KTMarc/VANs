//
//  EQLLicenceButtonView.m
//  VAN Selector
//
//  Created by Marc Humet on 15/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceButtonView.h"

@implementation EQLLicenceButtonView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [VanStyleKit drawLicenceMenuButtonWithColorParameter:[UIColor blackColor]];
}


@end
