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
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view endEditing:YES];
    // _result.hidden = false;
    
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
sharedForm.pesoCaballo = _easyFormHorseWeightTextField.text.integerValue;
    [self shouldPerformSegueWithIdentifier: @"toLicenceSegue" sender: self];
    
}

- (void)swipetoRightDetection{
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
sharedForm.pesoCaballo = _easyFormHorseWeightTextField.text.integerValue;    [self.navigationController popViewControllerAnimated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        weDoSegue = true;
    }
    
    return weDoSegue;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UIButton class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm4ViewController class]]){
            EQLLicenceForm4ViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.model;
        }
    }
}

- (IBAction)toForm4Button:(UIButton *)sender {
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    /* -------------------------------------------------------*/
    
    sharedForm.pesoCaballo = _easyFormHorseWeightTextField.text.integerValue;
}
@end
