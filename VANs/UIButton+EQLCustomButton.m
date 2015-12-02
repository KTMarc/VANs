//
//  UIButton+EQLCustomButton.m
//  VAN Selector
//
//  Created by Marc Humet on 12/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "UIButton+EQLCustomButton.h"

@implementation UIButton (EQLCustomButton)

- (NSString *)fontName {
    return self.titleLabel.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.titleLabel.font = [UIFont fontWithName:fontName size:self.titleLabel.font.pointSize];
}

@end
