//
//  EQLmodeloVan.h
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQLmodeloVan : NSObject

@property (copy, nonatomic) NSString *Name;
@property (strong, nonatomic, readonly) UIImage *photo;
@property (strong, nonatomic) NSURL *webURL;
@property (copy, nonatomic) NSString *specs;
@property (nonatomic) int horsesNum;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSArray *ptacs;
@property (nonatomic) int weight;
@property (nonatomic) int maxPtacForClientsCar;


// Constructor (class method)
+(id) vanWithName: (NSString *) aName
            photo: (UIImage *)aPhoto
           webURL: (NSURL *) awebURL
            specs: (NSString *) aSpecs
        horsesNum: (int) ahorsesNum
            price: (NSString *) aPrice
            ptacs: (NSArray *) ptacs
           weight: (int) aweight
           maxPtacForClientsCar: (int) maxPtacForClientsCar;


// Initializer
-(id) initWithName: (NSString *) aName
             photo: (UIImage *)aPhoto
           webURL: (NSURL *) awebURL
            specs: (NSString *) aSpecs
        horsesNum: (int) ahorsesNum
             price: (NSString *) aPrice
             ptacs: (NSArray *) ptacs
            weight: (int) aweight
           maxPtacForClientsCar: (int) maxPtacForClientsCar;


@end
