//
//  EQLAppDelegate.m
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLAppDelegate.h"
//#import <GoogleMaps/GoogleMaps.h>
//#import <Parse/Parse.h>

@implementation EQLAppDelegate

- (void)customiseAppeareance
{
    UIColor *colorEquus = [UIColor colorWithRed:255./255.0 green:102.0/255.0 blue:102/255.0
                                           alpha:1.0];
    
    [[UISegmentedControl appearance] setTintColor:colorEquus];
    [[UIButton appearance] setTintColor:colorEquus];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self customiseAppeareance];
  //  [GMSServices provideAPIKey:@"AIzaSyDDnCFkUcGIWVRkYmbhLCHMkfa6jTpI0Fw"];
    
    [Parse setApplicationId:@"BYpZjCJR6Fc65Kp0vDrxL0s0eEJvH6RCITynyp0z"
                  clientKey:@"rrjGk2sy6Tpb4RTa3IYntgWrU3x5nrA6qR1Wav2V"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //Instanciamos el singleton para poder guardar alli lo que tengamos en NSUserdefaults
    
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    
    BOOL debugMode= true;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // comprobamos si no hay nada porque es la primera vez que abrimos la app.
    if (![defaults objectForKey:@"mmaCar"]) {
        //EN PRODUCCION HAY QUE CONTEMPLAR TODOS LOS CASOS
        //NSLog(@"NSUserdefaults esta vacio");
    } else {
        //NSLog(@"NSUserdefaults esta LLENO");
        //Copiamos lo que tenemos guardado en nuestro singleton.
        if (!debugMode){
            NSLog(@"Cargamos los NSUserDefaults");
            sharedForm.mmaCar = [defaults integerForKey:@"mmaCar"];
            sharedForm.mmrCar = [defaults integerForKey:@"mmrCar"];
            sharedForm.licence = [defaults integerForKey:@"licence"];
            sharedForm.pesoCaballo = [defaults integerForKey:@"pesoCaballo"];
        }
    }
    // A partir de aquí siempre que se acceda a la clave
    // dirección, sabremos que al menos hay el valor por
    // defecto
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    //Guardar en NSUserdefaults antes de salir
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: sharedForm.mmaCar forKey:@"mmaCar"];
    [defaults setInteger: sharedForm.mmrCar forKey:@"mmrCar"];
    [defaults setInteger: sharedForm.licence forKey:@"licence"];
    [defaults setInteger: sharedForm.pesoCaballo forKey:@"pesoCaballo"];
    [defaults synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //Guardar en NSUserdefaults antes de salir
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: sharedForm.mmaCar forKey:@"mmaCar"];
    [defaults setInteger: sharedForm.mmrCar forKey:@"mmrCar"];
    [defaults setInteger: sharedForm.licence forKey:@"licence"];
    [defaults setInteger: sharedForm.pesoCaballo forKey:@"pesoCaballo"];
    [defaults synchronize];

}

@end
