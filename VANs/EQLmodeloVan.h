//
//  EQLmodeloVan.h
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQLmodeloVan : NSObject

@property (strong, nonatomic) PFObject *PFVan;
@property (strong, nonatomic) NSString *calculationText;
@property (nonatomic) int maxPtacForClientsCar;

// Constructor (class method)
+(id) modeloVanWithPFVan: (PFObject *)aPFVan
         calculationText: (NSString *)aCalculationText
    maxPtacForClientsCar: (int) amaxPtacForClientsCar;


// Designated Initializer
-(id) initWithPFVan: (PFObject *)aPFVan
    calculationText: (NSString *)aCalculationText
maxPtacForClientsCar: (int) amaxPtacForClientsCar;


@end
