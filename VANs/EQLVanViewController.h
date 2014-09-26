//
//  EQLVanViewController.h
//  VANs
//
//  Created by Marc Humet on 02/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLmodeloVan.h"

@interface EQLVanViewController : UIViewController

@property (strong, nonatomic) EQLmodeloVan *van;
@property (strong, nonatomic) PFObject *parseVan;

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numHorsesLabel;
@property (strong, nonatomic) IBOutlet UILabel *ptacsLabel;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;


- (IBAction)callButton:(id)sender;



@end
