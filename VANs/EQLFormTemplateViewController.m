//
//  EQLFormTemplateViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 4/7/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLFormTemplateViewController.h"

@interface EQLFormTemplateViewController ()

@end

@implementation EQLFormTemplateViewController

//NSLog(@"Tenemos este modelo cuando llegamos a Form1:%@", self.model);

//Prepare de warning message

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedForm = [EQLFormData sharedForm];
    _logs = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) initialSetup:(UILabel *) wrongValueWarningLabel andTextField:(UITextField *) textField andSegueId:(NSString *) segueId andDataMissing: (NSString *)dataMissingMessage {
    
    _textFieldPadre = textField;
    _segueIdPadre = segueId;
    _dataMissingMessage = dataMissingMessage;

    wrongValueWarningLabel.alpha = 0;
    [wrongValueWarningLabel setTextColor: [VanStyleKit vermellEquus]];

    //esto se podria hacer en storyboards arrastrando desde el panel derecho, ultima opcion de la toolbar del textfield
    //Texfield actions when it is first responder (EditingDidBegin) and when text starts to change (EditingChanged)
    
    [textField addTarget:self action:@selector(textFieldEditingChangedAction:andMaxLength:andWarningLabel:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(changeFontAction:) forControlEvents: UIControlEventEditingDidBegin];
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view endEditing:YES];
    // _result.hidden = false;
    self.navigationController.navigationBarHidden = false;
    
    
    /*-----"DONE" BUTTON IN NUMERIC PAD ---*/
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:
                                      UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"OK"
                                      style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(doneClicked:)];
    doneBarButton.tintColor = [VanStyleKit vermellEquus];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    textField.inputAccessoryView = keyboardToolbar;
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

- (void)handleSingleTap
{
    [self.view endEditing:YES];
}

- (void)swipetoLeftDetection
{
    if (_logs) {  NSLog(@"SwipeToLeft, antes de guardar en el singleton, tenemos esto en el textfield: %@", _textFieldPadre.text);}
    [self saveDataToSingleton:(_textFieldPadre)];
    [self performSegueWithIdentifier: _segueIdPadre sender: self];
}

- (void)swipetoRightDetection
{
    [self saveDataToSingleton:(_textFieldPadre)];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper methods

- (void)saveDataToSingleton:(UITextField *)textField{
    
        if ([[textField restorationIdentifier] isEqualToString:@"mma"]){
            _sharedForm.mmaCar = textField.text.integerValue;
            if (_logs) {NSLog(@"El nombre que tiene el textField en storyboards es: %@", [textField restorationIdentifier]);}
            if (_logs) {NSLog(@"SUPER: Guardamos en el SINGLETON MMA CAR: %ld", (long)_sharedForm.mmaCar);}
        }
        if ([[textField restorationIdentifier] isEqualToString:@"mmr"]){
        _sharedForm.mmrCar = textField.text.integerValue;
        if (_logs) {NSLog(@"SUPER: Guardamos en el SINGLETON MMR CAR: %ld", (long)_sharedForm.mmrCar);}
        }
        if ([[textField restorationIdentifier] isEqualToString:@"horseWeight"]){
            _sharedForm.pesoCaballo = textField.text.integerValue;
        if (_logs) {NSLog(@"SUPER: Guardamos en el SINGLETON PESO CABALLOS: %ld", (long)_sharedForm.pesoCaballo);}
        }
}

#pragma mark - TextField interaction

- (void)doneClicked:(UITextField *)textField
{
    [textField endEditing:YES];
}


- (void)textFieldEditingChangedAction:(UITextField *)textField andMaxLength:(NSNumber *) number andWarningLabel:(UILabel *) wrongLabelLabel{
    //  NSLog(@"REcibimos mensaje de que el texto ha cambiado");
    [self checkTypedTextContentSizeWithMaxLength:@4 andTextField:textField andLabel:wrongLabelLabel];
     [self changeFontAction:textField];
}

- (void)changeFontAction:(UITextField *)textField{
    //NSLog(@"UIControlEventEditingDidBegin");
    textField.font =[UIFont fontWithName:sameFontEverywhere size:textField.font.pointSize];
}

- (void)checkTypedTextContentSizeWithMaxLength: (NSNumber *)maxLength andTextField:(UITextField *) textField andLabel:(UILabel *) wrongValueWarningLabel
{
    if ([textField.text length] < [maxLength unsignedIntegerValue]){
        [textField setTextColor:[UIColor redColor]];
        textField.alpha = 0;
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ textField.alpha = 1;}
                         completion:nil];
        
    }else{
        // NSLog(@"El string es 4 o mas");
        [textField setTextColor:[UIColor blackColor]];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ wrongValueWarningLabel.alpha = 0;}
                         completion:nil];
        wrongValueWarningLabel.alpha = 0;
    }
}

#pragma mark - Navigation

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    bool weDoSegue=true;
    bool flagSomethingIsMissing = false;
    
    if ([identifier isEqualToString: _segueIdPadre]){
        //We check if the user entered all he has to enter
        NSMutableString *missingEntry = [NSMutableString stringWithString: @"Faltan los siguientes datos:\n"];
        if([_textFieldPadre.text length] == 0){
            flagSomethingIsMissing = true;
            [missingEntry appendString:_dataMissingMessage];
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
    [self saveDataToSingleton:_textFieldPadre];
    return weDoSegue;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    NSLog(@"Entramos al prepareforSegue de Form1");
//    if ([sender isKindOfClass:[UIBarButtonItem class]]){
//        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm2ViewController class]]){
//            EQLLicenceForm2ViewController *nextViewController = segue.destinationViewController;
//            nextViewController.model = self.model;
//            // NSLog(@"Entramos en el prepareForSegue de Form1 : Tenemos este modelo cuando estamos a punto de saltar a Form2:%@", self.model);
//        }
//    }
//#pragma mark - CUIDADO con la clase que decimos que venimos! no es lo mismo un UIBarButtonItem que un UIButton normal.
//    
//    if ([sender isKindOfClass:[UIButton class]]){
//        if ([segue.destinationViewController isKindOfClass:[EQLLicenceFormViewController class]]){
//            EQLLicenceFormViewController *nextViewController = segue.destinationViewController;
//            nextViewController.model = self.model;
//            //NSLog(@"Entramos al prepareforSegue del Form1 hacia el Form AVANZADO. Tenemos este modelo:%@", _model);
//        }
//    }
//}


@end
