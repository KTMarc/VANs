//
//  EQLLicenceForm1ViewController.h
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import <UIKit/UIKit.h>
#import "EQLFormTemplateViewController.h"


//#import "EQLFormData.h"

@interface EQLLicenceForm1ViewController : EQLFormTemplateViewController

@property (strong, nonatomic) IBOutlet UITextField *easyFormMmaTextField;
@property (strong, nonatomic) IBOutlet UIButton *toHelp;
@property (strong, nonatomic) IBOutlet UILabel *wrongValueWarningLabel;

@end
