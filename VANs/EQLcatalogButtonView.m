//
//  EQLcatalogButtonView.m
//  VAN Selector
//
//  Created by Marc Humet on 14/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLcatalogButtonView.h"
@interface EQLcatalogButtonView()

@property BOOL isPressed;

@end

@implementation EQLcatalogButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [VanStyleKit drawCatalogMenuButtonWithFrame:self.bounds];
    // Drawing code
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isPressed = YES;
    [VanStyleKit drawCatalogMenuButtonWithButtonPressed:0.6];

//    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isPressed = NO;
    [VanStyleKit drawCatalogMenuButtonWithButtonPressed:1.0];
   // [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

@end
