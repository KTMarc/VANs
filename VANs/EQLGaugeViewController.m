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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)newAmountInTextField:(UITextField *)textField{

    self.gaugeView.pressure = [NSNumber numberWithInteger: [textField.text integerValue]];
    [self.gaugeView setNeedsDisplay];
    
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
