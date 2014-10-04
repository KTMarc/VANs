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
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
