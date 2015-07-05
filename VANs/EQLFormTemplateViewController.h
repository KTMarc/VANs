//
//  EQLFormTemplateViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 4/7/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLGarageModel.h"



@interface EQLFormTemplateViewController : UIViewController <UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) EQLGarageModel *model;
@property (nonatomic, strong) EQLFormData *sharedForm;
@property (nonatomic, strong) UITextField *textFieldPadre;
@property (nonatomic,strong) NSString *segueIdPadre;
@property (nonatomic,strong) NSString *dataMissingMessage;
@property (nonatomic) BOOL logs;

- (void) initialSetup:(UILabel *) wrongValueWarningLabel andTextField:(UITextField *) textField andSegueId:(NSString *) segueId andDataMissing: (NSString *)dataMissingMessage;

- (void)handleSingleTap;

- (void)swipetoLeftDetection;

- (void)swipetoRightDetection;

- (void)doneClicked:(UITextField *)textField;

- (void)textFieldEditingChangedAction:(UITextField *)textField andMaxLength:(NSNumber *) number andWarningLabel:(UILabel *) wrongLabelLabel;

- (void)changeFontAction:(UITextField *)textField;

- (void)checkTypedTextContentSizeWithMaxLength: (NSNumber *)maxLength andTextField:(UITextField *) textField andLabel:(UILabel *) wrongValueWarningLabel;

- (void)saveDataToSingleton:(UITextField *)textField;

@end
