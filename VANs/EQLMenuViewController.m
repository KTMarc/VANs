//
//  EQLMenuViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 13/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLMenuViewController.h"
#import "EQLCatalogTableViewController.h"
#import "EQLLicenceFormViewController.h"
#import "EQLLicenceForm1ViewController.h"
#import "EQLcatalogButtonView.h"
#import "EQLLicenceButtonView.h"
#import "EQLGarageModel.h"

@interface EQLMenuViewController ()

@end

@implementation EQLMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Fondo de la vista principal
    self.view.backgroundColor = [UIColor grayColor];
    
    
#pragma mark - TODO: Aqui dentro hay un init que pone todo a 0 y se carga la persistencia
//    
//    //Este objeto es como un singleton, porque solo tendremos uno y pondremos todos los vans ahi.
//    self.garage = [[EQLGarageModel alloc]init];
//    
//    //Bajamos los vans de la red si no los tenemos en el localDataStore.
//    [self.garage doAsyncQueryToParse:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}


// TODO: AIXO HAURIA DE SER UN VIEW DIDAPPEAR, PERO LLABORS ES DEFEORMA EL MENU INICIAL. POSIBLEMENT AMB AUTOLAYOUTS ES PUGUI ARREGLAR. PERO DE MOMENT HO DEIXO AIXI

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /*Apariencia del navigation controller */
    //Queria sacar estas lineas de aqui y ponerlas en el EQLNavigationController, pero alli no funcionan.
    
    self.navigationController.hidesBarsOnSwipe = false;
    self.navigationController.hidesBarsOnTap = false;
    self.navigationController.hidesBarsWhenVerticallyCompact = false;
    self.navigationController.navigationBarHidden = false;

//    self.navigationController.navigationBarHidden = false;

    //Do de same animation so the user knows from which option did he came from
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    sharedForm.lastButtonPressed.alpha = 0.2;
    
    [self fadeWith:sharedForm.lastButtonPressed andDuration: 0.3 Delay:0.0 finalAlpha:1];
//    self.navigationController.hidesBarsOnSwipe = false;
//    self.navigationController.hidesBarsOnTap = false;
//    self.navigationController.hidesBarsWhenVerticallyCompact = false;
}

- (void)viewDidDisAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = false;
}

//ESTO NO VA
- (void)drawRect:(CGRect)rect {
    // Drawing code
  //  [VanStyleKit drawMenuBackgroundWithFrame:self.view.bounds];
}

#pragma mark - Buttons interaction

- (IBAction)touchUpInside:(UIView *)sender {
    [self fadeWith:sender andDuration: 0.1 Delay:0.0 finalAlpha:0.2];
    
    //To be able to repeat the animation when we come back to the menu and the user knows from where he comes from.
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    sharedForm.lastButtonPressed = sender;
    if ([sender isKindOfClass:[EQLcatalogButtonView class]]){
        [self fadeWith:sender andDuration: 1.0 Delay:0.0 finalAlpha:1.0];        
    }
  }

- (IBAction)touchDown:(id)sender {
    [self fadeWith:sender andDuration: 1.0 Delay:0.0 finalAlpha:0.5];
}

- (IBAction)touchCancel:(id)sender {
    [self fadeWith:sender andDuration: 1.0 Delay:0.0 finalAlpha:1.0];
}

- (IBAction)touchDragOutside:(id)sender {
    [self fadeWith:sender andDuration: 1.0 Delay:0.0 finalAlpha:1.0];
}

- (void) fadeWith:(UIView *)sender andDuration: (float)duration Delay:(float)delay finalAlpha:(float)alpha {
    [UIView animateWithDuration:duration
                          delay: delay
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         sender.alpha = alpha;
                     }
                     completion:nil];
}

/*
-(IBAction)buttonTapped:(UIButton *)button {
    EQLcatalogButtonView *buttonView = (EQLcatalogButtonView *)button;
   NSLog(@"hemos picado el puto boton que es un UIView");
    
   }
 */

#pragma mark Contact Buttons

- (IBAction)callButton:(id)sender {
    if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://931123940"]]){
    }


}

- (IBAction)sendEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = [NSString stringWithFormat:@"Consulta sobre VAN: %@", _parseVan[@"Name"]];
    
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"Mis datos son:<br /><br />Nombre:<br />Provincia:<br />Teléfono:<br /><hr>Tengo una consulta sobre el VAN <b>%@</b>...<br /> ",_parseVan[@"Name"]]; // Change the message body to HTML
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[EQLLicenceButtonView class]]){

        //Opcion avanzada: Ya no haria falta porque la hemos puesto dentro de la primera pantalla del formulario paso a paso.
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceFormViewController class]]){
            EQLLicenceFormViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.garage;
            NSLog(@"Entramos en el preparforsegue del formulario AVANAZADO");
            NSLog(@"%@", self.garage);
            //We pass the fulfiled array with all the vans inside.
        }
#pragma mark - FIX: Limpiar todo esto que ya no procede
        //Opcion paso a paso
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm1ViewController class]]){
            EQLLicenceForm1ViewController *nextViewController = segue.destinationViewController;
            //NSLog(@"Entramos en el preparforsegue del formulario PASO A PASO");
            //We pass the fulfiled array with all the vans inside.
            nextViewController.model = self.garage;
            //NSLog(@"Tenemos este modelo cuando estamos en el menu principal:%@", self.garage);

        }
        
        if ([segue.destinationViewController isKindOfClass:[EQLCatalogTableViewController class]]){
            EQLCatalogTableViewController *nextViewController = segue.destinationViewController;
#pragma mark - FIX: This is doing nothing because all the vans are downloaded in the tableViewController
            nextViewController.model = self.garage;
            //We pass the fulfiled array with all the vans inside.
        }
    }
    
}

@end
