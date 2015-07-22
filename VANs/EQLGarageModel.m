//
//  EQLGarageModel.m
//  VANs
//
//  Created by Marc Humet on 01/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLGarageModel.h"
#import "EQLmodeloVan.h"
#import "EQLFormData.h"

@interface EQLGarageModel()

//@property (strong, nonatomic, readwrite) NSArray *allVans;

@end

@implementation EQLGarageModel

#pragma mark - Properties

- (NSUInteger)oneHorseCount
{
    return [self.oneHorseVans count];
}

- (NSUInteger)twoHorseCount
{
    return [self.twoHorseVans count];
}

- (NSUInteger)threeHorseCount
{
    return [self.threeHorseVans count];
}

- (NSUInteger)fourHorseCount
{
    return [self.fourHorseVans count];
}

/*
- (void) calculateWithmma: (int) mma
                      mmr: (NSInteger *) mmr
                  licence: (NSInteger *) licence
              horseWeight: (NSInteger *) horseWeight{
    NSLog(@"mma vale: %i", mma);
    
}*/


- (void)doAsyncQueryToParse: (BOOL) testing{
    

        [_queryVans findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error){ NSLog(@"Error: %@ %@", error, [error userInfo]);
            } else {
                // NSLog(@"Successfully retrieved %lu vans.", (unsigned long)objects.count);
                if (testing) {
                    _testBlock(objects);
                    
                }
                self.allVans = [objects mutableCopy];
                
                for (id van in _allVans){
                    // NSLog(@"Entra al for");
                    PFObject *parseVan = van;
                    int numHorsesInPFObject = [[parseVan objectForKey:@"horsesNum"] intValue];
                    
                    //  switch ([van horsesNum]) {
                    //Put each object where it belongs by horses number
                    switch (numHorsesInPFObject) {
                        case 1:
                            [_oneHorseVans addObject:van];
                            break;
                        case 2:
                            [_twoHorseVans addObject:van];
                            break;
                        case 3:
                            [_threeHorseVans addObject:van];
                            break;
                        case 4:
                            [_fourHorseVans addObject:van];
                            break;
                        default:
                            self.executionFlag = YES;
                            break;
                    }
                }
                
                // Pin PFQuery results
                
                [PFObject pinAllInBackground:self.allVans];
                /*
                 NSLog(@"%lu", (unsigned long)_oneHorseVans.count);
                 NSLog(@"%lu", (unsigned long)_twoHorseVans.count);
                 NSLog(@"%lu", (unsigned long)_threeHorseVans.count);
                 NSLog(@"%lu", (unsigned long)_fourHorseVans.count);
                 */
                //NSLog(@"Numero de objetos en %lu", (unsigned long)[_allVans count]);
            }
        }];
}


#pragma mark - Init
-(id)init{
    
    if (self = [super init]) {
        self.executionFlag = false; //En realidad tendriamos que hacer un singleton
        
#pragma mark - TODO: productionFlag change for Production
        self.productionFlag = false;
        
        _oneHorseVans = [[NSMutableArray alloc]init];
        _twoHorseVans = [[NSMutableArray alloc]init];
        _threeHorseVans = [[NSMutableArray alloc]init];
        _fourHorseVans = [[NSMutableArray alloc]init];
       // _form = [[EQLFormData alloc]init];
   
        [_queryVans fromLocalDatastore];
        _queryVans = [PFQuery queryWithClassName:@"modeloVan"];
        [_queryVans orderByAscending:@"Priority"];
        [_queryVans whereKey:@"enabled" equalTo:@(YES)];
        
        if (!self.executionFlag){
            if (_productionFlag){
               // _queryVans.cachePolicy = kPFCachePolicyNetworkElseCache;
                
            }else{
                //_queryVans.cachePolicy = kPFCachePolicyCacheThenNetwork;
            }
        }
    }
return self;
}

//+ (NSArray *) allVans{
//   
//    //Nos construye el array con todos los modelos
//    NSMutableArray *allVans = [@[] mutableCopy];
//    return allVans;
//}



#pragma mark - Other

- (EQLmodeloVan *)oneHorseAtIndex:(NSUInteger)index
{
    return [self.oneHorseVans objectAtIndex:index];
}

- (EQLmodeloVan *)twoHorseAtIndex:(NSUInteger)index
{
    return [self.twoHorseVans objectAtIndex:index];
}

- (EQLmodeloVan *)threeHorseAtIndex:(NSUInteger)index
{
    return [self.threeHorseVans objectAtIndex:index];
}

- (EQLmodeloVan *)fourHorseAtIndex:(NSUInteger)index
{
    return [self.fourHorseVans objectAtIndex:index];
}

@end
