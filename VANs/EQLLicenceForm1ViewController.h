//
//  EQLLicenceForm1ViewController.h
//  
//
//  Created by Marc Humet on 4/10/14.
//
//

#import <UIKit/UIKit.h>
#import "EQLLicenceForm2ViewController.h"
#import "EQLFormData.h"

@interface EQLLicenceForm1ViewController : UIViewController <UIGestureRecognizerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *easyFormMmaTextField;
- (IBAction)toForm2Button:(UIButton *)sender;

@end
