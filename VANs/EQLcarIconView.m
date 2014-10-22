//
//  EQLcarIconView.m
//  VAN Selector
//
//  Created by Marc Humet on 18/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLcarIconView.h"

@implementation EQLcarIconView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [VanStyleKit drawCarNavIconWithFrame:self.bounds];
}


@end
