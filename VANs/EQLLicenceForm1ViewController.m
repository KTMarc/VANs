//
//  EQLLicenceForm1ViewController.m
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import "EQLLicenceForm1ViewController.h"
//#import "EQLLicenceForm2ViewController.h"
//#import "EQLLicenceFormViewController.h"


@interface EQLLicenceForm1ViewController ()

@end

@implementation EQLLicenceForm1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* CARGAMOS LO QUE TENGAMOS EN EL SINGLETON SIEMPRE PORQUE TIENE LA ULTIMA VERSION BUENA porque Viene de NSUserDefaults*/
    super.sharedForm = [EQLFormData sharedForm];
    if ([super.sharedForm mmaCar] != 0){ //En caso contrario no queremos cargar un 0
        _easyFormMmaTextField.text = [NSString stringWithFormat: @"%li",(long)[super.sharedForm mmaCar]];}
    
    [self initialSetup:_wrongValueWarningLabel
          andTextField:_easyFormMmaTextField
            andSegueId:@"toMaxPtacSegue"
        andDataMissing:@"MMA coche\n"
      andMaxTextFieldSize:@4];

}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"Entramos al prepareforSegue de Form1");
    if ([sender isKindOfClass:[UIBarButtonItem class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm2ViewController class]]){
            EQLLicenceForm2ViewController *nextViewController = segue.destinationViewController;
           nextViewController.model = self.model;
           // NSLog(@"Entramos en el prepareForSegue de Form1 : Tenemos este modelo cuando estamos a punto de saltar a Form2:%@", self.model);
        }
    }
#pragma mark - CUIDADO con la clase que decimos que venimos! no es lo mismo un UIBarButtonItem que un UIButton normal.
    
    if ([sender isKindOfClass:[UIButton class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceFormViewController class]]){
            EQLLicenceFormViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.model;
            //NSLog(@"Entramos al prepareforSegue del Form1 hacia el Form AVANZADO. Tenemos este modelo:%@", _model);
        }
    }
    
    [self saveDataToSingleton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
