//
//  EQLCarResultsTableTableViewController.m
//  VANs
//
//  Created by Marc Humet on 29/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLCarResultsTableViewController.h"


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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _noResultsLabel.hidden = YES;
    
    
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
//    for (id index in _resultsArray){
//        if ([index count]>0){ numResults++;}
//    }
//    
//    if (numResults == 0){ _noResultsLabel.hidden = NO;}
    
    numResults = 4;
    
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
    
    // Configure the cell...
    NSArray *aux; //Guardamos el array con el numero de caballos en el que vamos a trabajar.
    int maxWeightClient=0;

    PFObject *PFvan;
    //aux apuntara a la seccion (array) donde estemos: 1,2,3,4 caballos.
    //NSLog(@"Indexpath vale: %ld", (long)indexPath.section);
    aux=[_resultsArray objectAtIndex:indexPath.section];
    PFvan = [aux[indexPath.row] PFVan];
    maxWeightClient = [aux[indexPath.row] maxPtacForClientsCar];
    //NSLog(@"Peso maximo guardado es: %i",maxWeightClient);
    
    
    PFFile *thumbnail = PFvan[@"photo"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    //cell.imageView.image = thumbnailImageView.image;

    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [PFvan objectForKey:@"Name"];
    
    UILabel *priceLabel = (UILabel*) [cell viewWithTag:102];
    priceLabel.text = [PFvan objectForKey:@"price"];

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
    
    return cell;
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
        if ([segue.destinationViewController isKindOfClass:[EQLVanViewController class]]){
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            EQLVanViewController *nextViewController = segue.destinationViewController;
            NSArray *aux;
            aux=[_resultsArray objectAtIndex:indexPath.section];
            nextViewController.van = aux[indexPath.row];
        }
    }

}


@end
