//
//  EQLGarageModel.h
//  VANs
//
//  Created by Marc Humet on 01/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EQLmodeloVan.h"

#define ONE_HORSE_KEY        @"1 caballo"
#define TWO_HORSE_KEY      @"2 caballos"
#define THREE_HORSE_KEY    @"3 caballos"
#define FOUR_HORSE_KEY      @"4 caballos"

@interface EQLGarageModel : NSObject

@property (nonatomic, readonly) NSUInteger oneHorseCount;
@property (nonatomic, readonly) NSUInteger twoHorseCount;
@property (nonatomic, readonly) NSUInteger threeHorseCount;
@property (nonatomic, readonly) NSUInteger fourHorseCount;

+ (NSArray *) allVans;

- (EQLmodeloVan *)oneHorseAtIndex:(NSUInteger)index;
- (EQLmodeloVan *)twoHorseAtIndex:(NSUInteger)index;
- (EQLmodeloVan *)threeHorseAtIndex:(NSUInteger)index;
- (EQLmodeloVan *)fourHorseAtIndex:(NSUInteger)index;

@end
