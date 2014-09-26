//
//  EQLViewController.h
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLmodeloVan.h"
#import "EQLGarageModel.h"
#import "EQLCarResultsTableViewController.h"


@interface EQLLicenceFormViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) int licence;
@property (nonatomic, strong) NSArray *availableWeights;
@property (nonatomic, strong) NSArray *allVans;
//@property (nonatomic, strong) EQLGarageModel *garage;
@property (nonatomic, strong) NSArray *resultsArray;
//UI elements

@property (weak, nonatomic) IBOutlet UISegmentedControl *licenceSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *ptacCarTextField;
@property (weak, nonatomic) IBOutlet UITextField *mmrCarTextField;
@property (weak, nonatomic) IBOutlet UITextField *horseWeight;

- (IBAction)technicalSheetButton:(UIButton *)sender;
- (IBAction)calculateWeight:(UIButton *)sender;


@end
