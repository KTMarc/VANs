//
//  EQLCalculationsCondition1.m
//  VAN Selector
//
//  Created by Marc Humet on 16/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLCalculationsCondition1.h"

IB_DESIGNABLE

@implementation EQLCalculationsCondition1


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    
    [VanStyleKit  drawCalculationResults1WithFrame: self.bounds
                                            mmaVan: [sharedForm mmaVanString]
                                             mmaCar: [NSString stringWithFormat: @"%liKg.",(long)[sharedForm mmaCar]]
                                          numHorses:[sharedForm numHorsesString]
                                            licence:[sharedForm licenceString]
                                           sumaMMAs:[NSString stringWithFormat: @"%liKg.",(long)([sharedForm mmaCar]+[sharedForm mmaVan])]
                                                     ];
    
}


@end
