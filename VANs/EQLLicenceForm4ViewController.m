//
//  EQLLicenceForm4ViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 4/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceForm4ViewController.h"

@interface EQLLicenceForm4ViewController ()

@end

@implementation EQLLicenceForm4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view endEditing:YES];
    // _result.hidden = false;
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toCarResultsButton:(UIButton *)sender {
    
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    sharedForm.licence = _easyFormLicenceSegmentedControl.selectedSegmentIndex;
    //NSLog(@"Segmented control index: %i", _easyFormLicenceSegmentedControl.selectedSegmentIndex);
    self.resultsArray = [sharedForm calculateThingsWithModel:_model];

    /* Tengo que hacer el Segue por codigo porque se me ejecutaba antes el prepareforSegue que el codigo de dentro del boton que lo llamaba */
    EQLCarResultsTableViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"carResults"];
    nextViewController.resultsArray = self.resultsArray;
    [self.navigationController pushViewController:nextViewController animated:YES];
}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UIButton class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLCarResultsTableViewController class]]){
            EQLCarResultsTableViewController *nextViewController = segue.destinationViewController;
            nextViewController.resultsArray = self.resultsArray;
        }
    }
    
}
 */

@end
