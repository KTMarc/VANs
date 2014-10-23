//
//  EQLLicenceForm1ViewController.h
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import <UIKit/UIKit.h>
#import "EQLLicenceForm2ViewController.h"
//#import "EQLFormData.h"

@interface EQLLicenceForm1ViewController : UIViewController <UIGestureRecognizerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *easyFormMmaTextField;
@property (nonatomic, strong) EQLGarageModel *model;


- (IBAction)toForm2Button:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *toHelp;


@end
