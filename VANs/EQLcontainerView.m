//
//  EQLcontainerView.m
//  VAN Selector
//
//  Created by Marc Humet on 3/3/16.
//  Copyright © 2016 EQUUS-LIFE. All rights reserved.
//

#import "EQLcontainerView.h"

@implementation EQLcontainerView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.9] CGColor];
}


@end
