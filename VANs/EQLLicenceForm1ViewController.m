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
    // Do any additional setup after loading the view.
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
    sharedForm.mmaCar = _easyFormMmaTextField.text.integerValue;
    [self shouldPerformSegueWithIdentifier: @"toMaxPtacSegue" sender: self];
    //[self performSegueWithIdentifier: @"toMaxPtacSegue" sender: self];
}

- (void)swipetoRightDetection{
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    sharedForm.mmaCar = _easyFormMmaTextField.text.integerValue;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneClicked:(id)sender
{
    [self.easyFormMmaTextField endEditing:YES];
    
    //NSLog(@"inside doneClicked:%@",[self.easyFormMmaTextField description]);

    self.gaugeView.pressure = [NSNumber numberWithInteger: [self.easyFormMmaTextField.text integerValue]];
    
    [self.gaugeView setNeedsDisplay];
    //    [self.gaugeView animatePath];

    
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
/*
    NSLog(@"we receive a new value in mmaNewValue:%@",[textField description]);
    self.gaugeView.pressure = [NSNumber numberWithInteger: [self.easyFormMmaTextField.text integerValue]];
    [self.gaugeView setNeedsDisplay];
    [textField resignFirstResponder];
 */
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSInteger inte = [textField.text intValue];
    if (inte <5 || inte > 2){
       UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"MMA" message:@"El Peso tiene que tener 4 cifras" delegate:self cancelButtonTitle:@"OK, voy!" otherButtonTitles: nil];
        [alerta show];
    
        return NO;
    }else{
        return YES;
    }
        
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

    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    
    sharedForm.mmaCar = _easyFormMmaTextField.text.integerValue;
    

}

@end
