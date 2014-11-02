//
//  EQLmyButton.m
//  VAN Selector
//
//  Created by Marc Humet on 31/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLmyButton.h"
#import "EQLLicenceForm1ViewController.h"

@implementation EQLmyButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
//    _buttonText = @"Estamos en Form1";
    _buttonText = @"SIGUIENTE";
    [VanStyleKit drawBotonEquusWithButtonText:_buttonText pressed:NO];

}


@end
