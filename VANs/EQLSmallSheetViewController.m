//
//  EQLSmallSheetViewController.m
//  VANs
//
//  Created by Marc Humet on 29/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLSmallSheetViewController.h"

@interface EQLSmallSheetViewController ()

@end

@implementation EQLSmallSheetViewController

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
     

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    
    /* Clase 126 curso 14 apps */
    

    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ejemploFichaA5.jpg"]];
//    NSLog(@" Frame antes: %", self.imageView.frame);
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.scrollView.contentSize = self.imageView.frame.size;
    [self.scrollView addSubview:self.imageView];
//    self.imageView.autoresizingMask = false;
    
    
    self.scrollView.contentMode = UIViewContentModeTop;
    
    /* Clase 128 */
//    self.scrollView.contentMode = UIViewContentModeTop;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.zoomScale = 0.8;
  
    // Center vertically de image inside de scrollview

    /*
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeTopMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.imageView
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.imageView
                                                               attribute:NSLayoutAttributeTopMargin
                                                              multiplier:1.0
                                                                constant:0.0]];
    */
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
    
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
