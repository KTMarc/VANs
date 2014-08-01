//
//  EQLCarResultsTableTableViewController.h
//  VANs
//
//  Created by Marc Humet on 29/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLGarageModel.h"
#import "EQLmodeloVan.h"

#define ONE_HORSE_SECTION       0
#define TWO_HORSE_SECTION       1
#define THREE_HORSE_SECTION     2
#define FOUR_HORSE_SECTION      3

#define SECTION_KEY @"section"
#define ROW_KEY @"row"


@interface EQLCarResultsTableTableViewController : UITableViewController

@property (strong, nonatomic) EQLGarageModel *model;
@property (nonatomic, strong) NSArray *resultsArray;


@end
