//
//  EQLmailButton.m
//  VAN Selector
//
//  Created by Marc Humet on 1/11/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLmailButton.h"

@implementation EQLmailButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [VanStyleKit drawMailButtonWithButtonText:@"Enviar mail"];
        [VanStyleKit drawMailButton];
}


@end
