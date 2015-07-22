//
//  EQLLicenceForm4ViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 4/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EQLGarageModel;


@interface EQLLicenceForm4ViewController : UIViewController <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *easyFormLicenceSegmentedControl;
@property (strong, nonatomic) EQLGarageModel *model;
@property (nonatomic, strong) NSArray *resultsArray;

- (IBAction)toCarResultsButton:(UIButton *)sender;

@end
