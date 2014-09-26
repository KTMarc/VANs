//
//  EQLMenuTableViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 04/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLCatalogTableViewController.h"
#import "EQLLicenceFormViewController.h"


@interface EQLMenuTableViewController : UITableViewController

@property (nonatomic, strong) EQLGarageModel *garage;
@property (nonatomic, strong) NSArray *vansArray;
//@property (nonatomic, strong) NSArray *allVans;

@end
