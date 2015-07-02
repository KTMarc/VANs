//
//  EQLmodeloVan.m
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLmodeloVan.h"

@implementation EQLmodeloVan


// Constructor (class method)
+(id) modeloVanWithPFVan: (PFObject *)aPFVan
         calculationText: (NSString *)aCalculationText
    maxPtacForClientsCar: (int) amaxPtacForClientsCar {    
    
    return [[self alloc]initWithPFVan:(PFObject *)aPFVan
                      calculationText:(NSString *)aCalculationText
                 maxPtacForClientsCar: (int) amaxPtacForClientsCar
            ];
}

// Initializer
-(id) initWithPFVan: (PFObject *)aPFVan
    calculationText: (NSString *)aCalculationText
maxPtacForClientsCar: (int) amaxPtacForClientsCar {
    
    if (self = [super init]) {
    _PFVan = aPFVan;
    _calculationText = aCalculationText;
    _maxPtacForClientsCar = amaxPtacForClientsCar;
    }
    return self;
}

@end
