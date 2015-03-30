//
//  EQLCalculationsCondition2.m
//  VAN Selector
//
//  Created by Marc Humet on 22/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLCalculationsCondition2.h"

@implementation EQLCalculationsCondition2


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    
    NSString *weightHorses = [NSString stringWithFormat:@"%liKg.", (long)[sharedForm pesoCaballo]*[sharedForm numHorses]];
    
    NSString *weightTrailerAndHorses = [NSString stringWithFormat:@"%liKg.",(long)(([sharedForm pesoCaballo]*[sharedForm numHorses])+[sharedForm trailerWeight])];
    [VanStyleKit drawCalculationResults2WithMmaVan:[sharedForm mmaVanString]
                                         numHorses:[sharedForm numHorsesString]
                                       weightHorse:[NSString stringWithFormat: @"%liKg.",(long)[sharedForm pesoCaballo]]
                                      weightHorses: weightHorses
                                     weightTrailer:[NSString stringWithFormat: @"%liKg.",(long)[sharedForm trailerWeight]]
                            weightTrailerAndHorses: weightTrailerAndHorses];
}


@end
