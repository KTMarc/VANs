//
//  EQLlicenceHelpView.m
//  VAN Selector
//
//  Created by Marc Humet on 1/11/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLlicenceHelpView.h"

IB_DESIGNABLE

@implementation EQLlicenceHelpView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [VanStyleKit drawLicencesHelpWithFrame:self.bounds];
}


@end
