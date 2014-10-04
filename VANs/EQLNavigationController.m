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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:255./255.0 green:102.0/255.0 blue:102/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:255./255.0 green:102.0/255.0 blue:102/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = YES;    
    
    
    
    /* Esto aqui no chuta */
    //    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
//    self.navigationController.navigationBar.translucent = YES;
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
