//
//  EQLCarResultsTableTableViewController.m
//  VANs
//
//  Created by Marc Humet on 29/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLCarResultsTableViewController.h"
#import "EQLGarageModel.h"
#import "EQLmodeloVan.h"
#import "EQLVanViewController.h"
#import "EQLCalculationsViewController.h"

@interface EQLCarResultsTableViewController ()

@end

@implementation EQLCarResultsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //DZNEmptyDataSource --------------------------
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    //---------------------------------------------
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.hidesBarsOnSwipe = false;
    self.navigationController.hidesBarsOnTap = false;
    self.navigationController.hidesBarsWhenVerticallyCompact = false;
    self.navigationController.navigationBarHidden = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.

    NSUInteger numResults = 0;
    for (id index in _resultsArray){
        if ([index count]>0){ numResults++;}
    }
    
    if (numResults == 0){ /*_noResultsLabel.hidden = NO;*/}

    return numResults;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    NSInteger count = 0;
    
    if (section == ONE_HORSE_SECTION) {
        count = [self.resultsArray[0] count];
    }
    else if (section == TWO_HORSE_SECTION) {
        count = [self.resultsArray[1] count];    }
    else if (section == THREE_HORSE_SECTION) {
        count = [self.resultsArray[2] count];
    }
    else {
        count = [self.resultsArray[3] count];
    }
    
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    switch (section)
    {
        case 0:
            if ([self.resultsArray[0] count] > 0){ sectionName = @"1 Caballo";}
            break;
        case 1:
            if ([self.resultsArray[1] count] > 0){ sectionName = @"2 Caballos";}
            break;
        case 2:
            if ([self.resultsArray[2] count] > 0){ sectionName = @"3 Caballos";}
            break;
        case 3:
            if ([self.resultsArray[3] count] > 0){ sectionName = @"4 Caballos";}
            break;
        default:
            break;
    }
    return sectionName;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    // Configure the cell...
    NSArray *aux; //Guardamos el array con el numero de caballos en el que vamos a trabajar.
    int maxWeightClient=0;

    EQLFormData *sharedForm = [EQLFormData sharedForm];
    
    PFObject *PFvan;
    //aux apuntara a la seccion (array) donde estemos: 1,2,3,4 caballos.
    //NSLog(@"Indexpath vale: %ld", (long)indexPath.section);
    aux=[_resultsArray objectAtIndex:indexPath.section];

    PFvan = [aux[indexPath.row] PFVan];
    maxWeightClient = [aux[indexPath.row] maxPtacForClientsCar];
    //NSLog(@"Peso maximo guardado es: %i",maxWeightClient);
    
    PFFile *thumbnail = PFvan[@"photo"];
//    PFFile *userImageFile = anotherPhoto[@"imageFile"];
    
//    UIImageView *thumbnailImageView = (UIImageView*)[cell viewWithTag:100];
//    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.png"];
//    thumbnailImageView.file = thumbnail;
//    [thumbnailImageView loadInBackground];

    UIImageView *thumbnailImageView = (UIImageView*)[cell viewWithTag:100];
    [thumbnail getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            thumbnailImageView.image = image;
        }
    }];

    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [PFvan objectForKey:@"Name"];
    UILabel *priceLabel = (UILabel*) [cell viewWithTag:102];
    int auxInt = (int)[sharedForm mmrCar];
    priceLabel.text = [NSString stringWithFormat: @"%i", auxInt];
    
//    maxWeightClient = [PFvan[@"maxPtacForClientsCar"] intValue];
//    NSString *cadena = @"MMA:";
    
    NSString *cadena = @"MMA:";
    
//    UILabel *maxPtacLabel = (UILabel*) [cell viewWithTag:103];
//    maxPtacLabel.text = [cadena stringByAppendingString:[[[NSNumber alloc] initWithInt: maxWeightClient] stringValue]];
//    
    if (maxWeightClient != 0){
        UILabel *maxPtacLabel = (UILabel*) [cell viewWithTag:103];
        maxPtacLabel.text = [cadena stringByAppendingString:[[[NSNumber alloc] initWithInt: maxWeightClient] stringValue]];
    }
    
    UILabel *explanationLabel = (UILabel*) [cell viewWithTag:104];
    explanationLabel.text = [aux[indexPath.row] calculationText];;
    
    //In case we could have this trailer in the next licence, we offer it as an option.
    if ([aux[indexPath.row] needsBetterLicence]){
        thumbnailImageView.alpha = 0.5;
        nameLabel.alpha = 0.5;
        explanationLabel.alpha = 0.5;
    }
    return cell;
}

#pragma mark DZNEmptyDataSource

//The image for the empty state:
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_tableView_placeholder.jpg"];
}

//The image view animation
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

//The attributed string for the title of the empty state:
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Sin resultados para la combinación de pesos introducida";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//The attributed string for the description of the empty state:
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Intente cambiar de carné por uno superior o introducir los datos de otro coche";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

    //The background color for the empty state:
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

//Additionally, you can also adjust the vertical alignment of the content view (ie: useful when there is tableHeaderView visible):
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -self.tableView.tableHeaderView.frame.size.height/2.0f;
}

//Finally, you can separate components from each other (default separation is 11 pts):
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 20.0f;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

//Asks to know if the empty state should be rendered and displayed (Default is YES) :
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

//Asks for interaction permission (Default is YES) :
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

//Asks for scrolling permission (Default is NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

//Asks for image view animation permission (Default is NO) :
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
{
    return YES;
}

//Notifies when the dataset view was tapped:
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
{
    // Do something
}

//Notifies when the data set call to action button was tapped:
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    // Do something
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
 
- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Guardamos la celda que hemos seleccionado

    self.van=[_resultsArray objectAtIndex:indexPath.section];
    NSLog(@"%@", [self.van Name]);
    //Mirar donde apunta el puntero _van
    
//    NSLog(@"%@",[self.van[indexPath.row] Name])
 
    
}

  */



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLCalculationsViewController class]]){
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            EQLCalculationsViewController *nextViewController = segue.destinationViewController;
            NSArray *aux;
            aux=[_resultsArray objectAtIndex:indexPath.section];
            nextViewController.van = aux[indexPath.row];

            EQLmodeloVan *aux2 = aux[indexPath.row];
            PFObject *PFvan = aux2.PFVan;
            
            EQLFormData *sharedForm = [EQLFormData sharedForm];
            sharedForm.mmaVanString = [NSString stringWithFormat: @"%iKg.", [aux2 maxPtacForClientsCar]];
            sharedForm.mmaVan = [aux2 maxPtacForClientsCar];
            sharedForm.numHorsesString = [NSString stringWithFormat: @"%i", [PFvan[@"horsesNum"] intValue]];
            sharedForm.numHorses = [PFvan[@"horsesNum"] intValue];
            sharedForm.trailerWeight = [PFvan[@"weight"] intValue];
            
            
        }
    }
}


@end
