//
//  EQLVanViewController.m
//  VANs
//
//  Created by Marc Humet on 02/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

//Pasamos por Segue: _parseVanOrigen (en EQLCatalogTableViewController.m)
//                   _van.PFVan (en EQLCalculationsViewController.m)

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
    
   // self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
   // self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    //self.navigationController.navigationBar.translucent = YES;

    
    //_parseVan = _van.PFVan;
    UILabel *nameLabel = (UILabel*) [self.view viewWithTag:101];
    nameLabel.text = _parseVan[@"Name"];
    self.navigationController.title= nameLabel.text;
//    NSLog(@"Nombre del VaN:%@",_parseVan[@"Name"]);
    
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

#pragma mark Contact Buttons

- (IBAction)callButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://931123940"]];
}

- (IBAction)sendEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = [NSString stringWithFormat:@"Consulta sobre VAN:%@", _parseVan[@"Name"]];

    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"Mis datos son:<br /><br />Nombre:<br />Provincia:<br />Teléfono:<br /><hr>Tengo una consulta sobre el VAN<b>%@</b>...<br /> ",_parseVan[@"Name"]]; // Change the message body to HTML
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"info@equus-life.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    if ([MFMailComposeViewController canSendMail]){
        [self presentViewController:mc animated:YES completion:NULL];
    } else {
        UIAlertView *noMail = [[UIAlertView alloc] initWithTitle:@"No tienes correo" message:@"No tienes configurada ninguna cuenta de correo, configura una y vuelve. Sino, siempre puedes llamarnos!" delegate:self cancelButtonTitle:@"Vale" otherButtonTitles: nil];
        [noMail show];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    bool logs=false;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            if (logs) NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            if (logs)  NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            if (logs) NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            if (logs) NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
