//
//  EQLLicenceForm3ViewController.m
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import "EQLLicenceForm3ViewController.h"

@interface EQLLicenceForm3ViewController ()

@end

@implementation EQLLicenceForm3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Prepare de warning message
    _wrongValueWarningLabel.alpha = 0;
    [_wrongValueWarningLabel setTextColor: [VanStyleKit vermellEquus]];
    
    //esto se podria hacer en storyboards arrastrando desde el panel derecho, ultima opcion de la toolbar del textfield
    //Texfield actions when it is first responder (EditingDidBegin) and when text starts to change (EditingChanged)
    [_easyFormHorseWeightTextField addTarget:self action:@selector(textFieldEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
    [_easyFormHorseWeightTextField addTarget:self action:@selector(changeFontAction) forControlEvents: UIControlEventEditingDidBegin];
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view endEditing:YES];
    // _result.hidden = false;
    self.navigationController.navigationBarHidden = false;
    
    
    /* CARGAMOS LO QUE TENGAMOS EN EL SINGLETON SIEMPRE PORQUE TIENE LA ULTIMA VERSION BUENA*/
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    if ([sharedForm pesoCaballo] != 0){ //En caso contrario no queremos cargar un 0
        //Cargamos lo que tenga el singleton, que a la vez viene de NSUserDefaults
        _easyFormHorseWeightTextField.text = [NSString stringWithFormat: @"%li",(long)[sharedForm pesoCaballo]];}
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
    self.easyFormHorseWeightTextField.inputAccessoryView = keyboardToolbar;
    /*-----END   "DONE" BUTTON IN NUMERIC PAD ---*/
    
    
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

#pragma mark - Gestures

- (void)swipetoLeftDetection{
    [self performSegueWithIdentifier: @"toLicenceSegue" sender: self];
    
}

- (void)swipetoRightDetection{
    [self saveDataToSingleton:(_easyFormHorseWeightTextField)];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneClicked:(id)sender
{
    [self.easyFormHorseWeightTextField endEditing:YES];
}
/*-----ENF OF "DONE" BUTTON IN NUMERIC PAD ---*/

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

- (void)textFieldEditingChangedAction:(UITextField *)sender {
    //  NSLog(@"REcibimos mensaje de que el texto ha cambiado");
  //  [self checkTypedTextContentSize:(sender.text) withMaxLength:@4];
    [self changeFontAction];
}

- (void)changeFontAction{
    _easyFormHorseWeightTextField.font =[UIFont fontWithName:sameFontEverywhere size:_easyFormHorseWeightTextField.font.pointSize];
}

- (void)checkTypedTextContentSize: (NSString *)string withMaxLength: (NSNumber *)maxLength
{
//    if ([_easyFormHorseWeightTextField.text length] < [maxLength unsignedIntegerValue]){
//        [_easyFormHorseWeightTextField setTextColor:[UIColor redColor]];
//        _wrongValueWarningLabel.alpha = 0;
//        
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
//                         animations:^{ _wrongValueWarningLabel.alpha = 1;}
//                         completion:nil];
//        
//    }else{
//        // NSLog(@"El string es 4 o mas");
//        [_easyFormHorseWeightTextField setTextColor:[UIColor blackColor]];
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
//                         animations:^{ _wrongValueWarningLabel.alpha = 0;}
//                         completion:nil];
//        _wrongValueWarningLabel.alpha = 0;
//    }
}

#pragma mark - Helper methods

- (void)saveDataToSingleton:(UITextField *)textField{
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    sharedForm.pesoCaballo = textField.text.integerValue;
    NSLog(@"Guardamos en el SINGLETON pesoCaballo: %ld", (long)sharedForm.pesoCaballo);
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    bool weDoSegue=true;
    bool flagSomethingIsMissing = false;
    
    if ([identifier isEqualToString: @"toLicenceSegue"]){
        //We check if the user entered all he has to enter
        
        NSMutableString *missingEntry = [NSMutableString stringWithString: @"Faltan los siguientes datos:\n"];
        if([_easyFormHorseWeightTextField.text length] == 0){
            flagSomethingIsMissing = true;
            [missingEntry appendString:@"Peso medio de sus caballos\n"];
        }
        
        if (flagSomethingIsMissing){
            weDoSegue = false;
            UIAlertView *missingDataAlert = [[UIAlertView alloc] initWithTitle:@"Atención" message:missingEntry delegate:self cancelButtonTitle:@"OK, voy!" otherButtonTitles: nil];
            [missingDataAlert show];
        }
    } else{
        //Estamos en los segues del tabView y podemos hacer la transición.
        [self saveDataToSingleton:(_easyFormHorseWeightTextField)];
        weDoSegue = true;
    }
    
    return weDoSegue;
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UIBarButtonItem class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm4ViewController class]]){
            EQLLicenceForm4ViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.model;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
