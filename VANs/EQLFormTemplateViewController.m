//
//  EQLFormTemplateViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 4/7/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLFormTemplateViewController.h"
#import "EQLGarageModel.h"


@interface EQLFormTemplateViewController ()

@end

@implementation EQLFormTemplateViewController

//NSLog(@"Tenemos este modelo cuando llegamos a Form1:%@", self.model);

//Prepare de warning message

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedForm = [EQLFormData sharedForm];
    _logs = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewWillDisappear:(BOOL)animated {
    //http://stackoverflow.com/questions/1214965/setting-action-for-back-button-in-navigation-controller
       //Save before moving backwards.
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
    [self saveDataToSingleton];
    [super viewWillDisappear:animated];
}

- (void) initialSetup:(UILabel *) wrongValueWarningLabel andTextField:(UITextField *) textField andSegueId:(NSString *) segueId andDataMissing: (NSString *)dataMissingMessage andMaxTextFieldSize:(NSNumber *)maxTextFieldSize{
    
    _textFieldPadre = textField;
    _segueIdPadre = segueId;
    _dataMissingMessage = dataMissingMessage;
    _maxTextFieldSize = maxTextFieldSize;
    _wrongValueWarningLabelPadre = wrongValueWarningLabel;

    wrongValueWarningLabel.alpha = 0;
    [wrongValueWarningLabel setTextColor: [VanStyleKit vermellEquus]];

    //esto se podria hacer en storyboards arrastrando desde el panel derecho, ultima opcion de la toolbar del textfield
    //Texfield actions when it is first responder (EditingDidBegin) and when text starts to change (EditingChanged)
    
    [textField addTarget:self action:@selector(textFieldEditingChangedAction) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(changeFontAction) forControlEvents: UIControlEventEditingDidBegin];
    
    
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

    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:
                                      UIBarButtonSystemItemSave target:self action:
                                      @selector(doneClicked)];

    saveBarButton.style = UIBarButtonSystemItemSave;
    keyboardToolbar.items = @[flexBarButton, saveBarButton];
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
  //  [self saveDataToSingleton];
    if ([self shouldPerformSegueWithIdentifier:_segueIdPadre sender:self]) {
        [self performSegueWithIdentifier: _segueIdPadre sender: self];
    }else{
        //We show a pop up (it´s in the other function below shouldPerfom....)
    }
}

- (void)swipetoRightDetection
{
    //[self saveDataToSingleton];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper methods

- (void)saveDataToSingleton{
    
    if ([[_textFieldPadre restorationIdentifier] isEqualToString:@"mma"]){
        _sharedForm.mmaCar = _textFieldPadre.text.integerValue;
        if (_logs) {NSLog(@"El nombre que tiene el textField en storyboards es: %@", [_textFieldPadre restorationIdentifier]);}
        if (_logs) {NSLog(@"SUPER: Guardamos en el SINGLETON MMA CAR: %ld", (long)_sharedForm.mmaCar);}
    }
    if ([[_textFieldPadre restorationIdentifier] isEqualToString:@"mmr"]){
        _sharedForm.mmrCar = _textFieldPadre.text.integerValue;
        if (_logs) {NSLog(@"SUPER: Guardamos en el SINGLETON MMR CAR: %ld", (long)_sharedForm.mmrCar);}
    }
    if ([[_textFieldPadre restorationIdentifier] isEqualToString:@"horseWeight"]){
        _sharedForm.pesoCaballo = _textFieldPadre.text.integerValue;
        if (_logs) {NSLog(@"SUPER: Guardamos en el SINGLETON PESO CABALLOS: %ld", (long)_sharedForm.pesoCaballo);}
    }
}

#pragma mark - TextField interaction

- (void)doneClicked
{
    [_textFieldPadre endEditing:YES];
    //To go directly to the next screen after entering the value
    [self swipetoLeftDetection];
}


- (void)textFieldEditingChangedAction{
    //  NSLog(@"REcibimos mensaje de que el texto ha cambiado");
    [self checkTypedTextContentSize];
     [self changeFontAction];
}

- (void)changeFontAction{
    //NSLog(@"UIControlEventEditingDidBegin");
    _textFieldPadre.font =[UIFont fontWithName:sameFontEverywhere size:_textFieldPadre.font.pointSize];
}

- (void)checkTypedTextContentSize
{
    if ([_textFieldPadre.text length] < [_maxTextFieldSize unsignedIntegerValue] | [_textFieldPadre.text length] > [_maxTextFieldSize unsignedIntegerValue]){
        [_textFieldPadre setTextColor:[UIColor redColor]];
        _wrongValueWarningLabelPadre.alpha = 0;
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ _wrongValueWarningLabelPadre.alpha = 1;}
                         completion:nil];
        
    }else{
        // NSLog(@"El string es 4 o mas");
        [_textFieldPadre setTextColor:[UIColor blackColor]];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ _wrongValueWarningLabelPadre.alpha = 0;}
                         completion:nil];
        _wrongValueWarningLabelPadre.alpha = 0;
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
        if([_textFieldPadre.text length] < [_maxTextFieldSize integerValue]){
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
    //Save before moving forward.
    //[self saveDataToSingleton];
    
    //To remove keyboard if the user didn't tap on 'done'
    [_textFieldPadre endEditing:YES];
    return weDoSegue;
}


@end
