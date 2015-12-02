//
//  EQLFlipSegue.m
//  VAN Selector
//
//  Created by Marc Humet on 1/8/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLFlipSegue.h"
#import "EQLLicenceForm1ViewController.h"

@implementation EQLFlipSegue

- (void) perform {
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.3
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                            [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
}

@end
