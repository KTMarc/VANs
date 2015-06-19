//
//  EQLGaugeViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 14/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLGaugeCarAndVanView.h"

@interface EQLGaugeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *mmaCar;

@property (weak, nonatomic) IBOutlet EQLGaugeCarAndVanView *gaugeView;

- (IBAction)newAmountInTextField:(id)sender;


@end


