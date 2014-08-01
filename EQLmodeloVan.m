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
         photoURL: (NSURL *)aPhotoURL
           webURL: (NSURL *) awebURL
            specs: (NSString *) aSpecs
        horsesNum: (int) ahorsesNum
            price: (NSString *) aPrice
            ptacs: (NSArray *) ptacs
           weight: (int) aweight;


{
    
    return [[self alloc]initWithName:(NSString *) aName
                            photoURL: (NSURL *)aPhotoURL
                              webURL: (NSURL *) awebURL
                               specs: (NSString *) aSpecs
                           horsesNum: (int) ahorsesNum
                               price: (NSString *) aPrice
                               ptacs: (NSArray *) ptacs
                              weight: (int) aweight
            ];
}

// Initializer
-(id) initWithName: (NSString *) aName
          photoURL: (NSURL *)aPhotoURL
            webURL: (NSURL *) awebURL
             specs: (NSString *) aSpecs
         horsesNum: (int) ahorsesNum
             price: (NSString *) aPrice
             ptacs: (NSArray *) ptacs
            weight: (int) aweight;{
    
    
    if (self = [super init]) {
        _Name = aName;
        _photoURL = aPhotoURL;
        _webURL = awebURL;
        _specs = aSpecs;
        _horsesNum = ahorsesNum;
        _price = aPrice;
        _ptacs = ptacs;
        _weight = aweight;
    }
    return self;
}


@end
