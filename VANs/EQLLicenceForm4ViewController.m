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

    /* CARGAMOS LO QUE TENGAMOS EN EL SINGLETON SIEMPRE PORQUE TIENE LA ULTIMA VERSION BUENA*/
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    if ([sharedForm licence] != -1){ //En caso contrario no queremos cargar un 0
        //Cargamos lo que tenga el singleton, que a la vez viene de NSUserDefaults
        _easyFormLicenceSegmentedControl.selectedSegmentIndex= [sharedForm licence];}
    /* FIN CARGA DE PERSISTENCIA ----------------------------------------------------------*/
    
    /* GESTURE RECOGNIZERS FOR NAVIGATION RIGHT AND LEFT*/
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipetoLeftDetection)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftGesture setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipetoRightDetection)];
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [rightGesture setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:rightGesture];
    /* END GESTURE RECOGNIZERS */
    
    
}

- (void)swipetoLeftDetection{
    [self toCarResultsButton:nil];
}

- (void)swipetoRightDetection{
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
 sharedForm.licence = _easyFormLicenceSegmentedControl.selectedSegmentIndex;
    [self.navigationController popViewControllerAnimated:YES];
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

    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Cuidado" message:@"Tienes que seleccionar un carné" delegate:self cancelButtonTitle:@"Vale"  otherButtonTitles: nil];
   // NSLog(@"Tu puta madre %i", [_easyFormLicenceSegmentedControl selectedSegmentIndex]);
    if ([_easyFormLicenceSegmentedControl selectedSegmentIndex] == -1){
        [alerta show];
    } else {
        EQLFormData *sharedForm = [EQLFormData sharedForm];
        /* -------------------------------------------------------*/
        sharedForm.licence = _easyFormLicenceSegmentedControl.selectedSegmentIndex;
        //NSLog(@"Segmented control index: %i", _easyFormLicenceSegmentedControl.selectedSegmentIndex);
        self.resultsArray = [sharedForm calculateThingsWithModel:_model];
        
        /* Tengo que hacer el Segue por codigo porque se me ejecutaba antes el prepareforSegue que el codigo de dentro del boton que lo llamaba */
        EQLCarResultsTableViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"carResults"];
        nextViewController.resultsArray = self.resultsArray;
        [self.navigationController pushViewController:nextViewController animated:YES];
//       [self shouldPerformSegueWithIdentifier: @"toLicenceSegue" sender: self];
    }
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
