//
//  EQLViewController.h
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EQLGarageModel;

@interface EQLLicenceFormViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) int licence;
@property (nonatomic, strong) NSArray *availableWeights;
//@property (nonatomic, strong) NSArray *allVans;
@property (strong, nonatomic) EQLGarageModel *model;
//@property (nonatomic, strong) EQLGarageModel *garage;
@property (nonatomic, strong) NSArray *resultsArray;
@property (nonatomic, strong) NSArray *resultsPtacsAndTexts;

//UI elements
@property (weak, nonatomic) IBOutlet UISegmentedControl *licenceSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *ptacCarTextField;
@property (weak, nonatomic) IBOutlet UITextField *mmrCarTextField;
@property (weak, nonatomic) IBOutlet UITextField *horseWeight;
@property (strong, nonatomic) IBOutlet UIButton *buttonToLongForm;

- (IBAction)technicalSheetButton:(UIButton *)sender;
- (IBAction)calculateWeight:(UIButton *)sender;
//- (IBAction)OKButton:(UIButton *)sender;



@end
