//
//  EQLCalculationsViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 15/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQLmodeloVan.h"
#import "EQLVanViewController.h"
//#import "EQLFormData.h"

@interface EQLCalculationsViewController : UIViewController

@property (strong, nonatomic) EQLmodeloVan *van;
@property (strong, nonatomic) PFObject *parseVan;

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numHorsesLabel;
@property (strong, nonatomic) IBOutlet UILabel *ptacsLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIButton *toViewVanButton;
@property (strong, nonatomic) IBOutlet UILabel *greenTextLabel;


@end
