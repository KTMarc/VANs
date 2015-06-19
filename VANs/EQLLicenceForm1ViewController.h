//
//  EQLLicenceForm1ViewController.h
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import <UIKit/UIKit.h>
#import "EQLLicenceForm2ViewController.h"
#import "EQLGaugeCarAndVanView.h"

//#import "EQLFormData.h"

@interface EQLLicenceForm1ViewController : UIViewController <UIGestureRecognizerDelegate,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet EQLGaugeCarAndVanView *gaugeView;
@property (strong, nonatomic) IBOutlet UITextField *easyFormMmaTextField;
@property (nonatomic, strong) EQLGarageModel *model;
@property (strong, nonatomic) IBOutlet UIButton *toHelp;

- (IBAction)mmaNewValue:(id)sender;
- (IBAction)toForm2Button:(UIButton *)sender;

@end
