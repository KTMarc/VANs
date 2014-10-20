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
