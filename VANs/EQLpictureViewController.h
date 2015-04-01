//
//  EQLpictureViewController.h
//  VAN Selector
//
//  Created by Marc Humet on 11/11/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
    #import <Parse/Parse.h>

@interface EQLPictureViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) PFObject *parseVan;
@property (strong, nonatomic) IBOutlet PFImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end
