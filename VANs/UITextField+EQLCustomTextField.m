//
//  UITextField+EQLCustomTextField.m
//  VAN Selector
//
//  Created by Marc Humet on 12/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "UITextField+EQLCustomTextField.h"

@implementation UITextField (EQLCustomTextField)

- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
}


@end
