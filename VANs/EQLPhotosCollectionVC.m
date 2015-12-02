//
//  EQLPhotosCollectionVC.m
//  VAN Selector
//
//  Created by Marc Humet on 12/7/15.
//  Copyright (c) 2015 EQUUS-LIFE. All rights reserved.
//

#import "EQLPhotosCollectionVC.h"

@implementation EQLPhotosCollectionVC

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    layout.sectionInset = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
    layout.minimumInteritemSpacing = 5.0f;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    const CGRect bounds = UIEdgeInsetsInsetRect(self.view.bounds, layout.sectionInset);
    CGFloat sideSize = MIN(CGRectGetWidth(bounds), CGRectGetHeight(bounds)) / 2.0f - layout.minimumInteritemSpacing;
    layout.itemSize = CGSizeMake(sideSize, sideSize);
}


#pragma mark Query

- (PFQuery *)queryForCollection {
    PFQuery *query = [super queryForCollection];
    [query orderByAscending:@"priority"];
    return query;
}

#pragma mark CollectionView

- (PFCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                  object:(PFObject *)object {
    PFCollectionViewCell *cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath object:object];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:object[@"title"] attributes:nil];
    NSAttributedString *priorityString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\nPriority: %@", object[@"priority"]]
                                                                         attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                                                                       NSForegroundColorAttributeName : [UIColor grayColor] }];
    [title appendAttributedString:priorityString];
    cell.textLabel.attributedText = title;
    
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    return cell;
}

@end
