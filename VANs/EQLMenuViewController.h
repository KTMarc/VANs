//
//  EQLMenuViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 13/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class EQLGarageModel;

@interface EQLMenuViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) EQLGarageModel *garage;
@property (nonatomic, strong) NSArray *vansArray;
@property (nonatomic, strong) PFObject *parseVan;

- (IBAction)touchUpInside:(id)sender;
- (IBAction)touchDown:(id)sender;
- (IBAction)touchCancel:(id)sender;
- (IBAction)touchDragOutside:(id)sender;


@end
