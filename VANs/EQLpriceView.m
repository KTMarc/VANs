//
//  EQLpriceView.m
//  VAN Selector
//
//  Created by Marc Humet on 3/11/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//


#import "EQLPriceView.h"

IB_DESIGNABLE

@implementation EQLPriceView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [VanStyleKit drawPriceLabelWithButtonText:_price];
}


@end
