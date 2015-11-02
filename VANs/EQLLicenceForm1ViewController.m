//
//  EQLLicenceForm1ViewController.m
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import "EQLLicenceForm1ViewController.h"
#import "EQLLicenceForm2ViewController.h"
#import "EQLLicenceFormViewController.h"

@interface EQLLicenceForm1ViewController ()

@end

@implementation EQLLicenceForm1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    super.sharedForm = [EQLFormData sharedForm];
    if ([super.sharedForm mmaCar] != 0){ //En caso contrario no queremos cargar un 0
        _easyFormMmaTextField.text = [NSString stringWithFormat: @"%li",(long)[super.sharedForm mmaCar]];}
    
    [self initialSetup:_wrongValueWarningLabel
          andTextField:_easyFormMmaTextField
            andSegueId:@"toMaxPtacSegue"
        andDataMissing:@"MMA coche\n"
      andMaxTextFieldSize:@4];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    super.sharedForm = [EQLFormData sharedForm];
    _easyFormMmaTextField.text = [NSString stringWithFormat: @"%li",(long)[super.sharedForm mmaCar]];
}

-(void)doneClicked{
    [super doneClicked];
    
//    EQLLicenceForm2ViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"toMaxPtacSegue"];
//    
//    [self.navigationController pushViewController:nextViewController animated:YES];
    
}

#pragma mark - Navigation
- (IBAction)unwind:(UIStoryboardSegue *)segue{
    //To be able to come back from the advanced mode viewController (EQLLicenceFormViewController)
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Better to avoid introspection to check who sent the event to segue. That way we don´t care if it was a gesture or a UIButton or a UIBarButtonItem
   // if ([sender isKindOfClass:[UIBarButtonItem class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm2ViewController class]]){
            EQLLicenceForm2ViewController *nextViewController = segue.destinationViewController;
           nextViewController.model = self.model;
        }
    //}

  //  if ([sender isKindOfClass:[UIButton class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceFormViewController class]]){
            EQLLicenceFormViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.model;
            //NSLog(@"Entramos al prepareforSegue del Form1 hacia el Form AVANZADO. Tenemos este modelo:%@", _model);
        }
  //  }
    //[self saveDataToSingleton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
