//
//  EQLLicenceForm2ViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 4/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceForm2ViewController.h"
#import "EQLLicenceForm3ViewController.h"


@interface EQLLicenceForm2ViewController ()

@end

@implementation EQLLicenceForm2ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* CARGAMOS LO QUE TENGAMOS EN EL SINGLETON SIEMPRE PORQUE TIENE LA ULTIMA VERSION BUENA porque Viene de NSUserDefaults*/
    super.sharedForm = [EQLFormData sharedForm];
    if ([super.sharedForm mmrCar]){ //En caso contrario no queremos cargar un 0
        _mmrFormTextField.text = [NSString stringWithFormat: @"%i",(int)[super.sharedForm mmrCar]];}
    
    [self initialSetup:_wrongValueWarningLabel
          andTextField:_mmrFormTextField
            andSegueId:@"toHorseWeightSegue"
        andDataMissing:@"MMR coche\n"
   andMaxTextFieldSize:@4];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  //  if ([sender isKindOfClass:[UIBarButtonItem class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm3ViewController class]]){
            EQLLicenceForm3ViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.model;
        }
    //}
   // [self saveDataToSingleton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
