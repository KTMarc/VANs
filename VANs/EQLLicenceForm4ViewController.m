//
//  EQLLicenceForm4ViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 4/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceForm4ViewController.h"
#import "EQLCarResultsTableViewController.h"

@interface EQLLicenceForm4ViewController ()

@end

@implementation EQLLicenceForm4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

-(void) viewWillDisappear:(BOOL)animated {
    //http://stackoverflow.com/questions/1214965/setting-action-for-back-button-in-navigation-controller
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
    [self saveDataToSingleton];
    [super viewWillDisappear:animated];
}

- (void)saveDataToSingleton{
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    sharedForm.licence = _easyFormLicenceSegmentedControl.selectedSegmentIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures

- (void)swipetoLeftDetection{
  //  [self saveDataToSingleton];
  //  [self toCarResultsButton:@"toLicenceSegue"];
    if ([self shouldPerformSegueWithIdentifier:@"toCarResults" sender:self]) {
        [self performSegueWithIdentifier:@"toCarResults" sender: self];
    }
}

- (void)swipetoRightDetection{
  //  [self saveDataToSingleton];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

- (IBAction)toCarResultsButton:(id)sender {
    
//        EQLFormData *sharedForm = [EQLFormData sharedForm];
//        /* -------------------------------------------------------*/
//        sharedForm.licence = _easyFormLicenceSegmentedControl.selectedSegmentIndex;
//      //  NSLog(@"Segmented control index: %i", _easyFormLicenceSegmentedControl.selectedSegmentIndex);
//
//        //Aqui pasamos nil porque el formulario lo pillamos dentro de la funcion que llamaremos ahora. PQ es un singleton
//        self.resultsArray = [sharedForm calculateThingsWithModel:_model andForm:nil];
//        
//        /* Tengo que hacer el Segue por codigo porque se me ejecutaba antes el prepareforSegue que el codigo de dentro del boton que lo llamaba */
//        EQLCarResultsTableViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"carResults"];
//        nextViewController.resultsArray = self.resultsArray;
//    
//        //NSLog(@"Después de ejectuar un calculatethings with model dentro de toCarResultsButton: %i %i %i %i", [self.resultsArray[0] count],[self.resultsArray[1] count],[self.resultsArray[2] count],[self.resultsArray[3] count]);
//     
//
//        [self.navigationController pushViewController:nextViewController animated:YES];
//        //[self shouldPerformSegueWithIdentifier: @"toLicenceSegue" sender: self];
}

- (void) presentAlert{
    UIAlertView *alertLicence = [[UIAlertView alloc]initWithTitle:@"Cuidado" message:@"Tienes que seleccionar un carné" delegate:self cancelButtonTitle:@"Vale"  otherButtonTitles: nil];
    [alertLicence show];
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    bool weDoSegue=true;
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    
    if ([_easyFormLicenceSegmentedControl selectedSegmentIndex] == -1){
        weDoSegue = false;
        [self presentAlert];
    } else{
        sharedForm.licence = _easyFormLicenceSegmentedControl.selectedSegmentIndex;
        self.resultsArray = [sharedForm calculateThingsWithModel:_model andForm:nil];
        weDoSegue = true;
    }
    return weDoSegue;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if ([sender isKindOfClass:[UIButton class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLCarResultsTableViewController class]]){
            EQLCarResultsTableViewController *nextViewController = segue.destinationViewController;
            nextViewController.resultsArray = self.resultsArray;
        }
    //}
    
}


@end
