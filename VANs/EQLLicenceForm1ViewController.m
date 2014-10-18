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

}

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
