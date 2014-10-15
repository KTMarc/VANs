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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255./255.0 green:102.0/255.0 blue:102/255.0 alpha:1.0]; //Fondo rojo equus
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]}; //Texto del titulo en blanco
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; //Texto de los botones en blanco
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    self.garage = [[EQLGarageModel alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidAppear:(BOOL)animated{
//        self.navigationController.navigationBarHidden = true;
//}


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
