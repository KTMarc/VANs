//
//  EQLVanViewController.h
//  VANs
//
//  Created by Marc Humet on 02/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "EQLmodeloVan.h"
#import "EQLPriceView.h"
#import "EQLNumHorsesView.h"
#import "EQLPictureViewController.h"

@interface EQLVanViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) EQLmodeloVan *van;
@property (strong, nonatomic) PFObject *parseVan;
@property (strong, nonatomic) PFImageView *fotoVan;

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;

@property (strong, nonatomic) IBOutlet UILabel *ptacsLabel;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;

- (IBAction)callButton:(id)sender;
- (IBAction)sendEmail:(id)sender;


@end
