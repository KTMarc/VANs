//
//  EQLCarPeopleLuggageView.m
//  VAN Selector
//
//  Created by Marc Humet on 19/7/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLCarPeopleLuggageView.h"

IB_DESIGNABLE

@implementation EQLCarPeopleLuggageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    [VanStyleKit drawCarPeopleLuggageWithFrame:self.bounds];
}


@end
