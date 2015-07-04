//
//  EQLNavigationController.m
//  VANs
//
//  Created by Marc Humet on 29/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLNavigationController.h"

@interface EQLNavigationController ()

@end

@implementation EQLNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotate
{
    id currentViewController = self.topViewController;
    
    //We don´t want the Main menu to rotate.
    if ([currentViewController isKindOfClass:[EQLMenuViewController class]])
        return NO;
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = YES;

    [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
            NSFontAttributeName: [UIFont fontWithName:sameFontEverywhere size:20],
            NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           }];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
            NSFontAttributeName: [UIFont fontWithName:sameFontEverywhere size:18],
            NSForegroundColorAttributeName : [UIColor whiteColor],}
            forState:UIControlStateNormal];
   
    // [VanStyleKit vermellEquus]
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

@end
