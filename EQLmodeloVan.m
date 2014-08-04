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
+(id) vanWithName: (NSString *) aName
         photo: (UIImage *)aPhoto
           webURL: (NSURL *) awebURL
            specs: (NSString *) aSpecs
        horsesNum: (int) ahorsesNum
            price: (NSString *) aPrice
            ptacs: (NSArray *) ptacs
           weight: (int) aweight
           maxPtacForClientsCar: (int) amaxPtacForClientsCar;


{
    
    return [[self alloc]initWithName:(NSString *) aName
                               photo: (UIImage *)aPhoto
                              webURL: (NSURL *) awebURL
                               specs: (NSString *) aSpecs
                           horsesNum: (int) ahorsesNum
                               price: (NSString *) aPrice
                               ptacs: (NSArray *) ptacs
                              weight: (int) aweight
                       maxPtacForClientsCar: (int) amaxPtacForClientsCar
            ];
}

// Initializer
-(id) initWithName: (NSString *) aName
             photo: (UIImage *)aPhoto
            webURL: (NSURL *) awebURL
             specs: (NSString *) aSpecs
         horsesNum: (int) ahorsesNum
             price: (NSString *) aPrice
             ptacs: (NSArray *) ptacs
            weight: (int) aweight
           maxPtacForClientsCar: (int) amaxPtacForClientsCar;
{
    
    
    if (self = [super init]) {
        _Name = aName;
        _photo = aPhoto;
        _webURL = awebURL;
        _specs = aSpecs;
        _horsesNum = ahorsesNum;
        _price = aPrice;
        _ptacs = ptacs;
        _weight = aweight;
        _maxPtacForClientsCar = amaxPtacForClientsCar;
    }
    return self;
}


@end
