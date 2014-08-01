//
//  EQLCarResultsTableTableViewController.m
//  VANs
//
//  Created by Marc Humet on 29/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLCarResultsTableTableViewController.h"


@interface EQLCarResultsTableTableViewController ()

@end

@implementation EQLCarResultsTableTableViewController

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

/*
// BACCUS
- (void)loadModel
{

    
    self.model = [[EQLGarageModel alloc] init];
    self.tableView.tableHeaderView = nil;
    [self.tableView reloadData];
    
    // Avisar al delegado
    //[self.delegate wineryTableViewController:self didSelectWine:[self lastSelectedWine]];
}

// FIN BACCUS
*/

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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *aux;

        aux=[_resultsArray objectAtIndex:indexPath.section];
        cell.textLabel.text = [aux[indexPath.row] Name];
        aux = [aux[indexPath.row] ptacs];
        cell.detailTextLabel.text = [aux componentsJoinedByString:@","];

        /* cell.imageView.image*/
        
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
