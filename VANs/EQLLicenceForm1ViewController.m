//
//  EQLLicenceForm1ViewController.m
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import "EQLLicenceForm1ViewController.h"


@interface EQLLicenceForm1ViewController ()

@end

@implementation EQLLicenceForm1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Prepare de warning message
    _wrongValueWarningLabel.alpha = 0;
    [_wrongValueWarningLabel setTextColor: [VanStyleKit vermellEquus]];

    //esto se podria hacer en storyboards arrastrando desde el panel derecho, ultima opcion de la toolbar del textfield
    //Texfield actions when it is first responder (EditingDidBegin) and when text starts to change (EditingChanged)
    [_easyFormMmaTextField addTarget:self action:@selector(textFieldEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
    [_easyFormMmaTextField addTarget:self action:@selector(changeFontAction) forControlEvents: UIControlEventEditingDidBegin];
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view endEditing:YES];
    // _result.hidden = false;
    self.navigationController.navigationBarHidden = false;
    
    
    
    /* CARGAMOS LO QUE TENGAMOS EN EL SINGLETON SIEMPRE PORQUE TIENE LA ULTIMA VERSION BUENA*/
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    if ([sharedForm mmaCar] != 0){ //En caso contrario no queremos cargar un 0
        //Cargamos lo que tenga el singleton, que a la vez viene de NSUserDefaults
        _easyFormMmaTextField.text = [NSString stringWithFormat: @"%li",(long)[sharedForm mmaCar]];}
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
    self.easyFormMmaTextField.inputAccessoryView = keyboardToolbar;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures

- (void)swipetoLeftDetection{
    [self saveDataToSingleton:(_easyFormMmaTextField)];
    [self performSegueWithIdentifier: @"toMaxPtacSegue" sender: self];
}

- (void)swipetoRightDetection{
    [self saveDataToSingleton:(_easyFormMmaTextField)];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TextField interaction

- (void)doneClicked:(id)sender
{
    [self.easyFormMmaTextField endEditing:YES];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

- (void)textFieldEditingChangedAction:(UITextField *)sender {
  //  NSLog(@"REcibimos mensaje de que el texto ha cambiado");
    [self checkTypedTextContentSize:(sender.text) withMaxLength:@4];
    [self changeFontAction];
}

- (void)changeFontAction{
    //NSLog(@"UIControlEventEditingDidBegin");
    _easyFormMmaTextField.font =[UIFont fontWithName:sameFontEverywhere size:_easyFormMmaTextField.font.pointSize];
}

- (void)checkTypedTextContentSize: (NSString *)string withMaxLength: (NSNumber *)maxLength
{
    if ([_easyFormMmaTextField.text length] < [maxLength unsignedIntegerValue]){
        [_easyFormMmaTextField setTextColor:[UIColor redColor]];
        _wrongValueWarningLabel.alpha = 0;
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ _wrongValueWarningLabel.alpha = 1;}
                         completion:nil];
        
    }else{
       // NSLog(@"El string es 4 o mas");
        [_easyFormMmaTextField setTextColor:[UIColor blackColor]];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ _wrongValueWarningLabel.alpha = 0;}
                         completion:nil];
        _wrongValueWarningLabel.alpha = 0;
    }
}

#pragma mark - Helper methods

- (void)saveDataToSingleton:(UITextField *)textField{
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    sharedForm.mmaCar = textField.text.integerValue;
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    bool weDoSegue=true;
    bool flagSomethingIsMissing = false;
    
    if ([identifier isEqualToString: @"toMaxPtacSegue"]){
        //We check if the user entered all he has to enter
        
        NSMutableString *missingEntry = [NSMutableString stringWithString: @"Faltan los siguientes datos:\n"];
        if([_easyFormMmaTextField.text length] == 0){
            flagSomethingIsMissing = true;
            [missingEntry appendString:@"MMA coche\n"];
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
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm2ViewController class]]){
            EQLLicenceForm2ViewController *nextViewController = segue.destinationViewController;
           nextViewController.model = self.model;
        }
    }
}



- (IBAction)toForm2Button:(UIButton *)sender {
    [self saveDataToSingleton:(_easyFormMmaTextField)];
}

@end
