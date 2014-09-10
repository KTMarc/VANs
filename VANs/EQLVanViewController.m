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
    
    NSArray *ptacsOne1Horse = @[@900,@1000,@1100,@1200,@1300,@1400];
    
    EQLmodeloVan *gt1 = [EQLmodeloVan
                         modeloVanWithName:@"GT1"
                         photo: [UIImage imageNamed: @"gt1.jpg"]
                         webURL:[NSURL URLWithString:@"http://www.equus-life.com/remolques/van-gt1-black"]
                         specs:@"Equipamiento basico:Barras traseras ajustables en dos posiciones 2 ventanas frontales con reja de protección Goma en la rampa y en el interior del VAN.Equipamiento opcional incluido:Cojines laterales"
                         horsesNum:1
                         price:@"3.633€"
                         ptacs:ptacsOne1Horse
                         weight:600
                         maxPtacForClientsCar:0
                         ];
    
    self.van = gt1;
    
    self.photoImageView.image = self.van.photo;
    self.NameLabel.text = self.van.Name;
    //  self.numHorsesLabel.text = self.van.horsesNum;
    self.detailsTextView.text = self.van.specs;
    //  self.ptacsLabel.text = self.van.ptacs;

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
