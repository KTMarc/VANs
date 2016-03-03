//
//  EQLLicenceForm3ViewController.m
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import "EQLLicenceForm3ViewController.h"
#import "EQLLicenceForm4ViewController.h"

@interface EQLLicenceForm3ViewController ()

@end

@implementation EQLLicenceForm3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* CARGAMOS LO QUE TENGAMOS EN EL SINGLETON SIEMPRE PORQUE TIENE LA ULTIMA VERSION BUENA porque Viene de NSUserDefaults*/
    super.sharedForm = [EQLFormData sharedForm];
    if ([super.sharedForm pesoCaballo]){ //En caso contrario no queremos cargar un 0
        _easyFormHorseWeightTextField.text = [NSString stringWithFormat: @"%i",(int)[super.sharedForm pesoCaballo]];}
    
    [self initialSetup:_wrongValueWarningLabel
          andTextField:_easyFormHorseWeightTextField
            andSegueId:@"toLicenceSegue"
        andDataMissing:@"Peso medio de sus caballos\n"
   andMaxTextFieldSize:@3];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([sender isKindOfClass:[UIBarButtonItem class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm4ViewController class]]){
            EQLLicenceForm4ViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.model;
        }
  //  }
  //  [self saveDataToSingleton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
