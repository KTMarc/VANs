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
    // Do any additional setup after loading the view.
    
    /*Apariencia del navigation controller */
//   colorWithRed:255./255.0 green:74.0/255.0 blue:74/255.0
   
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255./255.0 green:102.0/255.0 blue:102/255.0 alpha:1.0]; //Fondo rojo equus
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]}; //Texto del titulo en blanco
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; //Texto de los botones en blanco
    
    
    self.view.backgroundColor = [UIColor blackColor]; //Fondo negro

    
    
//    self.navigationController.navigationBarHidden = true;
    self.garage = [[EQLGarageModel alloc]init];
    
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
}



- (void)viewDidDisAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = false;
}


//ESTO NO VA
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [VanStyleKit drawMenuBackgroundWithFrame:self.view.bounds];
    
}


- (IBAction)botonApretado:(id)sender {

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
    if ([sender isKindOfClass:[UIButton class]]){

        //Opcion avanzada
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceFormViewController class]]){
            EQLLicenceFormViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.garage;
             //   NSLog(@"Entramos en el preparforsegue del formulario AVANAZADO");
            //We pass the fulfiled array with all the vans inside.
        }
        
        //Opcion paso a paso
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm1ViewController class]]){
            EQLLicenceForm1ViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.garage;
               //  NSLog(@"Entramos en el preparforsegue del formulario PASO A PASO");
            //We pass the fulfiled array with all the vans inside.
        }
        
        if ([segue.destinationViewController isKindOfClass:[EQLCatalogTableViewController class]]){
            EQLCatalogTableViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.garage;
            //We pass the fulfiled array with all the vans inside.
        }
    }
}

@end
