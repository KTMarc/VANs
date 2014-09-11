//
//  EQLAppDelegate.m
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLAppDelegate.h"

@implementation EQLAppDelegate

- (void)customiseAppeareance
{
    UIColor *colorEquus = [UIColor colorWithRed:1.0
                                           green:0.4
                                            blue:0.29
                                           alpha:1.0];
    
    [[UISegmentedControl appearance] setTintColor:colorEquus];
    [[UIButton appearance] setTintColor:colorEquus];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self customiseAppeareance];
    [Parse setApplicationId:@"BYpZjCJR6Fc65Kp0vDrxL0s0eEJvH6RCITynyp0z"
                  clientKey:@"rrjGk2sy6Tpb4RTa3IYntgWrU3x5nrA6qR1Wav2V"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
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
}

@end
