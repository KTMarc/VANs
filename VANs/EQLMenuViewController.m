//
//  EQLMenuViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 13/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLMenuViewController.h"

@interface EQLMenuViewController ()

@end

@implementation EQLMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Fondo de la vista principal
    self.view.backgroundColor = [UIColor grayColor];
    
    /*Apariencia del navigation controller */
    //Queria sacar estas lineas de aqui y ponerlas en el EQLNavigationController, pero alli no funcionan.

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255./255.0 green:102.0/255.0 blue:102/255.0 alpha:1.0]; //Fondo rojo equus
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; //Texto de los botones en blanco
//    self.navigationController.navigationBarHidden = true;
    
    //Este objeto es como un singleton, porque solo tendremos uno y pondremos todos los vans ahi.
#pragma mark - TODO Aqui dentro hay un init que pone todo a 0 y se carga la persistencia
    self.garage = [[EQLGarageModel alloc]init];
    
    //Bajamos los vans si no los tenemos en el localDataStore.
    
    //Aqui bajamos de la red todos los Vans
    [self.garage doAsyncQueryToParse:false];

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
    self.navigationController.navigationBarHidden = true;

    //Do de same animation so the user knows from which option did he came from
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    sharedForm.lastButtonPressed.alpha = 0.2;
    [self fadeWith:sharedForm.lastButtonPressed andDuration: 0.3 Delay:0.0 finalAlpha:1];
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
#pragma mark - FIX: parece todo igual y solo canvia Form / Form1
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
            nextViewController.model = self.garage;
            //We pass the fulfiled array with all the vans inside.
        }
    }
    
}

@end
