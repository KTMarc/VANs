//
//  EQLGarageModel.h
//  VANs
//
//  Created by Marc Humet on 01/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EQLmodeloVan.h"
#import "EQLFormData.h"


#define ONE_HORSE_KEY      @"1 caballo"
#define TWO_HORSE_KEY      @"2 caballos"
#define THREE_HORSE_KEY    @"3 caballos"
#define FOUR_HORSE_KEY     @"4 caballos"

@interface EQLGarageModel : NSObject

@property (nonatomic, readonly) NSUInteger oneHorseCount;
@property (nonatomic, readonly) NSUInteger twoHorseCount;
@property (nonatomic, readonly) NSUInteger threeHorseCount;
@property (nonatomic, readonly) NSUInteger fourHorseCount;

@property (strong, nonatomic) NSMutableArray *oneHorseVans;
@property (strong, nonatomic) NSMutableArray *twoHorseVans;
@property (strong, nonatomic) NSMutableArray *threeHorseVans;
@property (strong, nonatomic) NSMutableArray *fourHorseVans;

@property (strong, nonatomic) PFQuery *queryVans;

@property (nonatomic,copy)void (^testBlock)();

//@property (nonatomic, readonly, strong) NSArray *allVans;
@property (nonatomic, strong) NSArray *allVans;
//@property (nonatomic, strong) EQLFormData *form;
@property (nonatomic) BOOL executionFlag;
@property (nonatomic) BOOL productionFlag;


//+ (NSArray *) allVans;

- (void)doAsyncQueryToParse: (BOOL) testing;
- (EQLmodeloVan *)oneHorseAtIndex:(NSUInteger)index;
- (EQLmodeloVan *)twoHorseAtIndex:(NSUInteger)index;
- (EQLmodeloVan *)threeHorseAtIndex:(NSUInteger)index;
- (EQLmodeloVan *)fourHorseAtIndex:(NSUInteger)index;
/*
- (void) calculateWithmma: (int) mma
                      mmr: (NSInteger *) mmr
                  licence: (NSInteger *) licence
              horseWeight: (NSInteger *) horseWeight;

- (void) calculate;
*/

@end
