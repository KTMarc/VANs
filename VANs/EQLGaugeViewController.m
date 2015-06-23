//
//  EQLGaugeViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 14/6/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLGaugeViewController.h"

@interface EQLGaugeViewController ()

@end

@implementation EQLGaugeViewController

/*
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // Do any additional setup after loading the view.
    /*-----"DONE" BUTTON IN NUMERIC PAD ---*/
    
    /*
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"OK" style:UIBarButtonItemStyleDone
                                        target:self action:@selector(doneClicked:)];
    doneBarButton.tintColor = [VanStyleKit vermellEquus];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.mmaCar.inputAccessoryView = keyboardToolbar;
}

- (IBAction)newAmountInTextField:(UITextField *)textField{

    NSLog(@"Recibimos del textfield %@", textField.text);
    
    [CATransaction setAnimationDuration:1.0];
   // self.gaugeLayer.percentage = [textField.text floatValue];

}
*/
/*
- (void)doneClicked:(id)sender
{
    [self.mmaCar endEditing:YES];
    
    //NSLog(@"inside doneClicked:%@",[self.easyFormMmaTextField description]);
    
    //self.gaugeView.pressure = [NSNumber numberWithInteger: [self.easyFormMmaTextField.text integerValue]];
    
    //[self.gaugeView setNeedsDisplay];
    //    [self.gaugeView animatePath];
    
}
*/
    
- (IBAction)touchedArrow:(EQLGauge1View *)sender {
    
    [CATransaction setAnimationDuration:1.0];
    sender.percentage = 0.75;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
