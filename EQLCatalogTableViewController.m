//
//  EQLCatalogTableViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 04/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLCatalogTableViewController.h"

@interface EQLCatalogTableViewController ()

@end

@implementation EQLCatalogTableViewController

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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSUInteger temp = -1;
    
    switch (section) {
        case 0:
            temp = self.model.oneHorseCount;
           // NSLog(@"Entramos a contar los remolques de un caballo que tenemos y nos da %lu", (unsigned long)temp);
            break;
    
        case 1:
            temp = self.model.twoHorseCount;
            break;
        case 2:
            temp = self.model.threeHorseCount;
            break;
    
        case 3:
            temp = self.model.fourHorseCount;
            break;
            
        default:
            temp = 0;
            break;
    }
    return temp;
    
}

- (EQLmodeloVan *)wineForIndexPath:(NSIndexPath *)indexPath
{
    // Averiguamos de qué vino se trata
    EQLmodeloVan *van = nil;
    
    if (indexPath.section == 0) {
        van = [self.model oneHorseAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1) {
        van = [self.model twoHorseAtIndex:indexPath.row];
    }
    else if (indexPath.section == 2){
        van = [self.model threeHorseAtIndex:indexPath.row];
    }
    else {
        van = [self.model fourHorseAtIndex:indexPath.row];
    }
    
    return van;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"catalogCell" forIndexPath:indexPath];
    
    // Configure the cell...
    EQLmodeloVan *van;
    NSString *cadena;
    
    //van = [_model.allVans objectAtIndex:indexPath.row];

    switch (indexPath.section) {
        case 0:
            van = [_model oneHorseAtIndex:indexPath.row];
            break;
        case 1:
            van = [_model twoHorseAtIndex:indexPath.row];
            break;
        case 2:
            van = [_model threeHorseAtIndex:indexPath.row];
            break;
        case 3:
            van = [_model fourHorseAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }

    cell.textLabel.text = [van Name];
    cadena = @"Detalles:";
    cell.detailTextLabel.text = cadena;
//  cell.detailTextLabel.text = [cadena stringByAppendingString:[[[NSNumber alloc] initWithI:maxWeightClient] stringValue]];
    cell.imageView.image = [van photo];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    switch (section)
    {
        case 0:
            sectionName = @"1 Caballo";
            break;
        case 1:
            sectionName = @"2 Caballos";
            break;
        case 2:
            sectionName = @"3 Caballos";
            break;
        case 3:
            sectionName = @"4 Caballos";
            break;
        default:
            break;
    }
    return sectionName;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
