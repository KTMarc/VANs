//
//  EQLCalculationsViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 15/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLCalculationsViewController.h"

@interface EQLCalculationsViewController ()

@end

@implementation EQLCalculationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    // self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = YES;
    
    _parseVan = _van.PFVan;
    UILabel *nameLabel = (UILabel*) [self.view viewWithTag:101];
    nameLabel.text = _parseVan[@"Name"];
    
    PFFile *thumbnail = _parseVan[@"photo"];
    PFImageView *thumbnailImageView = (PFImageView*)[self.view viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    //cell.imageView.image = thumbnailImageView.image;
    
    UILabel *priceLabel = (UILabel*) [self.view viewWithTag:102];
    priceLabel.text = _parseVan[@"price"];
    
    UILabel *horsesLabel = (UILabel*) [self.view viewWithTag:103];
    horsesLabel.text = [_parseVan[@"horsesNum"] stringValue];
    
    UILabel *specsLabel = (UILabel*) [self.view viewWithTag:104];
    specsLabel.text = _parseVan[@"specs"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[EQLVanViewController class]]){
        EQLVanViewController *nextViewController = segue.destinationViewController;
        nextViewController.parseVan = _van.PFVan;
    }
}

@end
