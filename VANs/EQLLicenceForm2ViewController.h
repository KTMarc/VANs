//
//  EQLLicenceForm2ViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 4/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLFormData.h"
#import "EQLLicenceForm3ViewController.h"

@interface EQLLicenceForm2ViewController : UIViewController <UIGestureRecognizerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *mmrFormTextView;
@property (nonatomic, strong) EQLGarageModel *model;


- (IBAction)toForm3Button:(UIButton *)sender;



@end
