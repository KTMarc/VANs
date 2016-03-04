//
//  EQLAppDelegate.m
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLAppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
//#import <Answers/Answers.h>

//#import <GoogleMaps/GoogleMaps.h>

#if DEBUG
    #define MODE  "Debug"
#else
    #define MODE  "Production"
#endif

@implementation EQLAppDelegate

- (void)customiseAppeareance
{
    UIColor *colorEquus = [UIColor colorWithRed:255./255.0 green:102.0/255.0 blue:102/255.0
                                           alpha:1.0];
    
    [[UISegmentedControl appearance] setTintColor:colorEquus];
    [[UIButton appearance] setTintColor:colorEquus];
    [[UILabel appearance] setFontName:sameFontEverywhere];
    
    
}
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  

    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self customiseAppeareance];
  //  [GMSServices provideAPIKey:@"AIzaSyDDnCFkUcGIWVRkYmbhLCHMkfa6jTpI0Fw"];

    [Parse enableLocalDatastore];
    
    [Parse setApplicationId:@"BYpZjCJR6Fc65Kp0vDrxL0s0eEJvH6RCITynyp0z"
                  clientKey:@"rrjGk2sy6Tpb4RTa3IYntgWrU3x5nrA6qR1Wav2V"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //Instanciate singleton to save all data from NSUserdefaults
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    
    // We load everything from userDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //sharedForm.firstTimeLoad = [defaults integerForKey:@"firstTimeLoad"]; //0-->YES 1-->NO
    
    sharedForm.mmaCar = [defaults integerForKey:@"mmaCar"];
    sharedForm.mmrCar = [defaults integerForKey:@"mmrCar"];
    sharedForm.licence = [defaults integerForKey:@"licence"];
    sharedForm.pesoCaballo = [defaults integerForKey:@"pesoCaballo"];
    
    
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    if (environment[@"mma"]) {
        sharedForm.mmaCar = [environment[@"mma"] integerValue];
        sharedForm.mmrCar = [environment[@"mmr"]integerValue];
        sharedForm.licence = [environment[@"licence"]integerValue];
        sharedForm.pesoCaballo = [environment[@"horse"]integerValue];

    } else {
        // Set the default one
    }
    
#pragma mark TODO: Canviar esto para release
    BOOL debugMode= false;
    if (/*![defaults objectForKey:@"mmaCar"] && */debugMode){
        //We start with some default data just to avoid entering it manually.
        sharedForm.mmaCar = 2350;
        sharedForm.mmrCar = 1900;
        sharedForm.licence = 1;
        sharedForm.pesoCaballo = 450;
    }

    
    #ifdef DEBUG
        NSLog(@"\n\n Running in %s", MODE);
    #else
        NSLog(@"\n\n Running in: %s", MODE);
    #endif
    
    [Fabric with:@[[Crashlytics class]]];
   // [[Fabric sharedSDK] setDebug: YES];

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
    [self saveBeforeQuit];
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
    [self saveBeforeQuit];
}

- (void) saveBeforeQuit{
    //Guardar en NSUserdefaults antes de salir
    EQLFormData *sharedForm = [EQLFormData sharedForm];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: sharedForm.mmaCar forKey:@"mmaCar"];
    [defaults setInteger: sharedForm.mmrCar forKey:@"mmrCar"];
    [defaults setInteger: sharedForm.licence forKey:@"licence"];
    [defaults setInteger: sharedForm.pesoCaballo forKey:@"pesoCaballo"];
   // NSLog(@"First Time Load value: %i", (int)sharedForm.firstTimeLoad);
    [defaults setInteger: sharedForm.firstTimeLoad forKey:@"firstTimeLoad"]; //0-->YES 1-->NO
    [defaults synchronize];
}
@end
