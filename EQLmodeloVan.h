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
@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSURL *webURL;
@property (copy, nonatomic) NSString *specs;
@property (nonatomic) int horsesNum;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSArray *ptacs;
@property (nonatomic) int weight;

// Constructor (class method)
+(id) vanWithName: (NSString *) aName
         photoURL: (NSURL *)aPhotoURL
           webURL: (NSURL *) awebURL
            specs: (NSString *) aSpecs
        horsesNum: (int) ahorsesNum
            price: (NSString *) aPrice
            ptacs: (NSArray *) ptacs
           weight: (int) aweight;


// Initializer
-(id) initWithName: (NSString *) aName
         photoURL: (NSURL *)aPhotoURL
           webURL: (NSURL *) awebURL
            specs: (NSString *) aSpecs
        horsesNum: (int) ahorsesNum
             price: (NSString *) aPrice
             ptacs: (NSArray *) ptacs
            weight: (int) aweight;



@end
