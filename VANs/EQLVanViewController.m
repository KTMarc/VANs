//
//  EQLVanViewController.m
//  VANs
//
//  Created by Marc Humet on 02/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLVanViewController.h"

@interface EQLVanViewController ()

@end

@implementation EQLVanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)callButton:(id)sender {
}
@end
