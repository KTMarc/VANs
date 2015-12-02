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

//Effective Objective C book: Item 17 Implement the description method
- (NSString*) description{
    return [NSString stringWithFormat:@"%@ %@ %d", _PFVan, _calculationText, _maxPtacForClientsCar];
    
}

@end
