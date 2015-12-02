//
//  EQLCarLargeIconView.m
//  VAN Selector
//
//  Created by Marc Humet on 5/7/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLCarLargeIconView.h"

@implementation EQLCarLargeIconView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [VanStyleKit drawCarEditableWithFrame:self.bounds colorParameter:[UIColor clearColor] strokeColorParameter:[VanStyleKit vermellEquus] strokeWidth:1.0];
    
}


@end
