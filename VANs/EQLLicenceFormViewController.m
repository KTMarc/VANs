//
//  EQLViewController.m
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceFormViewController.h"


@interface EQLLicenceFormViewController ()

@end

#define CARNE_B     3500;
#define CARNE_B96   4250;
#define CARNE_ByE   7000;

@implementation EQLLicenceFormViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Esto es para que desaparezca el teclado numerico cada vez que piquemos fuera de él
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view endEditing:YES];
    
    self.navigationController.navigationBarHidden = false;
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


- (IBAction)calculateWeight:(UIButton *)sender {

    //We instantiate the singleton, which we can use from everywhere (http://www.galloway.me.uk/tutorials/singleton-classes/)
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    
    sharedForm.mmaCar = _ptacCarTextField.text.integerValue;
    sharedForm.mmrCar =_mmrCarTextField.text.intValue;
    sharedForm.pesoCaballo = _horseWeight.text.intValue;
    sharedForm.licence = _licenceSegmentedControl.selectedSegmentIndex;
    
    self.resultsArray = [sharedForm calculateThingsWithModel:_model];

}

// In a storyboard-based application, you will often want to do a little preparation before navigation
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



@end
