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

    self.navigationController.hidesBarsOnSwipe = true;
    self.navigationController.hidesBarsOnTap = true;
    self.navigationController.hidesBarsWhenVerticallyCompact = true;
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    PFFile *thumbnail = _parseVan[@"photo"];
    _imageView = (UIImageView*)[self.view viewWithTag:100];
    _imageView.image = [UIImage imageNamed:@"placeholder.png"];
    
#pragma mark TODO: Arreglar esto que me he cargado al actualizar Parse

    [thumbnail getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            _imageView.image = image;
        }
    }];
//    _imageView.image = thumbnail;


    self.scrollView.contentSize = self.imageView.frame.size;
//    [self.scrollView addSubview:self.imageView];
    self.scrollView.delegate = self;
    self.scrollView.zoomScale = 1.0;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.contentView;
    
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
