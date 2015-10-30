//
//  EQLViewController.m
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceFormViewController.h"
#import "EQLGarageModel.h"
#import "EQLmodeloVan.h"
#import "EQLCarResultsTableViewController.h"


@interface EQLLicenceFormViewController ()

@end

#define CARNE_B     3500;
#define CARNE_B96   4250;
#define CARNE_ByE   7000;

@implementation EQLLicenceFormViewController 


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //NSLog(@"Tenemos este modelo cuando llegamos a Form AVANZADO:%@", self.model);

    
    //Esto es para que desaparezca el teclado numerico cada vez que piquemos fuera de él
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view endEditing:YES];
    
    self.navigationController.navigationBarHidden = false;

//    [[UINavigationBar appearance] setTitleTextAttributes:@{
//        NSFontAttributeName: [UIFont fontWithName:sameFontEverywhere size:20],
//        NSForegroundColorAttributeName : [UIColor whiteColor],
//                                                                                 }];
//    
//    
    // _result.hidden = false;
    
    /* CARGAMOS LO QUE TENGAMOS EN EL SINGLETON SIEMPRE PORQUE TIENE LA ULTIMA VERSION BUENA*/
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    if ([sharedForm mmaCar] != 0){ //En caso contrario no queremos cargar un 0
        //Cargamos lo que tenga el singleton, que a la vez viene de NSUserDefaults
        _ptacCarTextField.text = [NSString stringWithFormat: @"%li",(long)[sharedForm mmaCar]];
        _mmrCarTextField.text = [NSString stringWithFormat: @"%li",(long)[sharedForm mmrCar]];
        _horseWeight.text = [NSString stringWithFormat: @"%li",(long)[sharedForm pesoCaballo]];
        _licenceSegmentedControl.selectedSegmentIndex = [sharedForm licence];
    
    }
    /* FIN CARGA DE PERSISTENCIA ----------------------------------------------------------*/
    
    
    /*-----"DONE" BUTTON IN NUMERIC PAD ---*/
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone
                                      target:self action:@selector(doneClicked:)];
    doneBarButton.tintColor = [VanStyleKit vermellEquus];
    
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.ptacCarTextField.inputAccessoryView = keyboardToolbar;

}

- (void)doneClicked:(id)sender
{
    [self.ptacCarTextField endEditing:YES];
}
    /*-----ENF OF "DONE" BUTTON IN NUMERIC PAD ---*/

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)technicalSheetButton:(UIButton *)sender {

}


- (IBAction)calculateWeight:(id)sender {

    //We instantiate the singleton, which we can use from everywhere (http://www.galloway.me.uk/tutorials/singleton-classes/)
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    
    sharedForm.mmaCar = _ptacCarTextField.text.integerValue;
    sharedForm.mmrCar =_mmrCarTextField.text.intValue;
    sharedForm.pesoCaballo = _horseWeight.text.intValue;
    sharedForm.licence = _licenceSegmentedControl.selectedSegmentIndex;
    
    self.resultsArray = [sharedForm calculateThingsWithModel:_model andForm:nil];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    bool weDoSegue;
    bool flagSomethingIsMissing = false;

    if ([identifier isEqualToString: @"toResultados"]){
    //We check if the user entered all he has to enter
        
        NSMutableString *missingEntry = [NSMutableString stringWithString: @"Faltan los siguientes datos:\n"];
        if([_ptacCarTextField.text length] == 0){
            flagSomethingIsMissing = true;
            [missingEntry appendString:@"MMA coche\n"];
        }
        if([_mmrCarTextField.text length] == 0){
            flagSomethingIsMissing = true;
            [missingEntry appendString:@"MMR coche\n"];
        }

        if([_horseWeight.text length] == 0){
            flagSomethingIsMissing = true;
            [missingEntry appendString:@"Peso caballo\n"];
        }
        
        if(_licenceSegmentedControl.selectedSegmentIndex == -1){
            flagSomethingIsMissing = true;
            [missingEntry appendString:@"Su carné de conducir\n"];
        }
        
        if (flagSomethingIsMissing){
            weDoSegue = false;
            UIAlertView *missingDataAlert = [[UIAlertView alloc] initWithTitle:@"Atención" message:missingEntry delegate:self cancelButtonTitle:@"OK, voy!" otherButtonTitles: nil];
            [missingDataAlert show];
        }
    } else{
        //We are now sure we can segue
        weDoSegue = true;
    }
    return weDoSegue;
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLCarResultsTableViewController class]]){
            EQLCarResultsTableViewController *nextViewController = segue.destinationViewController;
            nextViewController.resultsArray = self.resultsArray;
            //NSLog(@"Tenemos este modelo cuando llegamos a Form AVANZADO:%@", self.model);

        }
    }
}



@end
