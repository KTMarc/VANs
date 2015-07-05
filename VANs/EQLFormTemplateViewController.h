//
//  EQLFormTemplateViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 4/7/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLLicenceForm2ViewController.h"
#import "EQLLicenceFormViewController.h"

@interface EQLFormTemplateViewController : UIViewController <UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) EQLGarageModel *model;



@end
