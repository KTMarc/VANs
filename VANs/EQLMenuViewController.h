//
//  EQLMenuViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 13/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLCatalogTableViewController.h"
#import "EQLLicenceFormViewController.h"
#import "EQLLicenceForm1ViewController.h"
#import "EQLcatalogButtonView.h"

@interface EQLMenuViewController : UIViewController

@property (nonatomic, strong) EQLGarageModel *garage;
@property (nonatomic, strong) NSArray *vansArray;

- (IBAction)touchUpInside:(id)sender;
- (IBAction)touchDown:(id)sender;
- (IBAction)touchCancel:(id)sender;
- (IBAction)touchDragOutside:(id)sender;


@end
