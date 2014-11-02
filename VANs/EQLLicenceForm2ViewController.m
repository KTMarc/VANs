//
//  EQLLicenceForm2ViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 4/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceForm2ViewController.h"

@interface EQLLicenceForm2ViewController ()

@end

@implementation EQLLicenceForm2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    NSLog(@"El contenido de sharedForm es: %ld", (long)sharedForm.mmaCar);
    */
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view endEditing:YES];
    // _result.hidden = false;
    
    /* CARGAMOS LO QUE TENGAMOS EN EL SINGLETON SIEMPRE PORQUE TIENE LA ULTIMA VERSION BUENA*/
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    if ([sharedForm mmrCar] != 0){ //En caso contrario no queremos cargar un 0
        //Cargamos lo que tenga el singleton, que a la vez viene de NSUserDefaults
        _mmrFormTextView.text = [NSString stringWithFormat: @"%li",(long)[sharedForm mmrCar]];}
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
    self.mmrFormTextView.inputAccessoryView = keyboardToolbar;
    /*-----ENF OF "DONE" BUTTON IN NUMERIC PAD ---*/

    
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
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    sharedForm.mmrCar = _mmrFormTextView.text.integerValue;
    [self shouldPerformSegueWithIdentifier: @"toHorseWeightSegue" sender: self];

}

- (void)swipetoRightDetection{
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    sharedForm.mmrCar = _mmrFormTextView.text.integerValue;
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)doneClicked:(id)sender
{
    [self.mmrFormTextView endEditing:YES];
}
/*-----ENF OF "DONE" BUTTON IN NUMERIC PAD ---*/


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    bool weDoSegue=true;
    bool flagSomethingIsMissing = false;
    
    if ([identifier isEqualToString: @"toHorseWeightSegue"]){
        //We check if the user entered all he has to enter
        
        NSMutableString *missingEntry = [NSMutableString stringWithString: @"Faltan los siguientes datos:\n"];
        if([_mmrFormTextView.text length] == 0){
            flagSomethingIsMissing = true;
            [missingEntry appendString:@"MMR coche\n"];
        }
        
        if (flagSomethingIsMissing){
            weDoSegue = false;
            UIAlertView *missingDataAlert = [[UIAlertView alloc] initWithTitle:@"Atención" message:missingEntry delegate:self cancelButtonTitle:@"OK, voy!" otherButtonTitles: nil];
            [missingDataAlert show];
        }
        
        
    } else{
        //Estamos en los segues del tabView y podemos hacer la transición.
        weDoSegue = true;
    }
    
    return weDoSegue;
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UIButton class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm3ViewController class]]){
            EQLLicenceForm3ViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.model;
        }
    }
}


- (IBAction)toForm3Button:(UIButton *)sender {
    
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    
    sharedForm.mmrCar = _mmrFormTextView.text.integerValue;

    
}
@end
