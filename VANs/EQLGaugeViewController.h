//
//  EQLGaugeViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 14/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLGauge1Layer.h"
#import "EQLGauge1View.h"

@interface EQLGaugeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *mmaCar;


//@property (strong, nonatomic) EQLGauge1Layer *gaugeLayer;

//Este es el nombre que tiene en storyboards
//@property (strong, nonatomic) EQLGauge1View *gaugeView;


//- (IBAction)newAmountInTextField:(id)sender;


- (IBAction)touchedArrow:(EQLGauge1View *)sender;

@end


