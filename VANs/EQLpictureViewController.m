//
//  EQLpictureViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 11/11/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLPictureViewController.h"

@interface EQLPictureViewController ()

@end

@implementation EQLPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationItem.title = [NSString stringWithFormat:@"Modelo de VAN:%@", _parseVan[@"Name"]];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    PFFile *thumbnail = _parseVan[@"photo"];
    _imageView = (PFImageView*)[self.view viewWithTag:100];
    _imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    _imageView.file = thumbnail;
    [_imageView loadInBackground];

    self.scrollView.contentSize = self.imageView.frame.size;
//    [self.scrollView addSubview:self.imageView];
    self.scrollView.delegate = self;
    self.scrollView.zoomScale = 1.0;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
