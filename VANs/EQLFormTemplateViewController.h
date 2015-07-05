//
//  EQLFormTemplateViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 4/7/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EQLFormTemplateViewController : UIViewController <UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) EQLGarageModel *model;
@property (nonatomic, strong) EQLFormData *sharedForm;


- (void) initialSetup:(UILabel *) wrongValueWarningLabel andTextField:(UITextField *) textField andTargetForDoneButton:(id) target;

- (void)handleSingleTap:(UIView *)view;

- (void)swipetoLeftDetection:(NSString *) segueId andSender:(id)sender andTextField:(UITextField *)textField;

- (void)swipetoRightDetection:(UITextField *) textField;

- (void)doneClicked:(UITextField *)textField;

- (void)textFieldEditingChangedAction:(UITextField *)textField andMaxLength:(NSNumber *) number andWarningLabel:(UILabel *) wrongLabelLabel;

- (void)changeFontAction:(UITextField *)textField;

- (void)checkTypedTextContentSizeWithMaxLength: (NSNumber *)maxLength andTextField:(UITextField *) textField andLabel:(UILabel *) wrongValueWarningLabel;

- (void)saveDataToSingleton:(UITextField *)textField;

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender andTextField:(UITextField *)textField andSegueID:(NSString *)segue andDataMissingString: (NSString *)dataMissing;
@end
