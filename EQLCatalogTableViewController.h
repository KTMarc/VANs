//
//  EQLCatalogTableViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 04/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLGarageModel.h"

#define ONE_HORSE_SECTION       0
#define TWO_HORSE_SECTION       1
#define THREE_HORSE_SECTION     2
#define FOUR_HORSE_SECTION      3

@interface EQLCatalogTableViewController : PFQueryTableViewController

@property (strong, nonatomic) EQLGarageModel *model;
@property (strong, nonatomic) PFObject *parseVanOrigen;
@property (nonatomic) int oneHorseCount,twoHorseCount,threeHorseCount,fourHorseCount;
@property (nonatomic) BOOL executionFlag;

//@property (nonatomic, strong) NSArray *vansArray;
//@property (nonatomic, strong) NSMutableArray *vansArray;

@end
