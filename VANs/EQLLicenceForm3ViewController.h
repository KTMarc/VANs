//
//  EQLLicenceForm3ViewController.h
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import <UIKit/UIKit.h>
//#import "EQLFormData.h"
#import "EQLLicenceForm4ViewController.h"

@interface EQLLicenceForm3ViewController : UIViewController <UIGestureRecognizerDelegate>
- (IBAction)toForm4Button:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *easyFormHorseWeightTextField;
@property (nonatomic, strong) EQLGarageModel *model;

@property (strong, nonatomic) IBOutlet UILabel *wrongValueWarningLabel;

@end
