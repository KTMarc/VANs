//
//  EQLLicenceForm2ViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 4/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLFormTemplateViewController.h"
#import "EQLLicenceForm3ViewController.h"

@interface EQLLicenceForm2ViewController : EQLFormTemplateViewController


@property (strong, nonatomic) IBOutlet UITextField *mmrFormTextField;
@property (strong, nonatomic) IBOutlet UIButton *toHelp;
@property (strong, nonatomic) IBOutlet UILabel *wrongValueWarningLabel;


@end
