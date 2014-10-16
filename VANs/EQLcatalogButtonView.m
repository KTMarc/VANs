//
//  EQLcatalogButtonView.m
//  VAN Selector
//
//  Created by Marc Humet on 14/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLcatalogButtonView.h"

@implementation EQLcatalogButtonView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    [VanStyleKit drawLogoChevalWithFrame:self.bounds];
    
    
}


@end
