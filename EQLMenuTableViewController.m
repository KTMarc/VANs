//
//  EQLMenuTableViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 04/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//


// Recibe [self.garage allVans] de MenuTableViewController

#import "EQLMenuTableViewController.h"

@interface EQLMenuTableViewController ()

@end

@implementation EQLMenuTableViewController

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
    
    /*Apariencia del navigation controller */
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.29 alpha:1.0]; //Fondo rojo equus
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]}; //Texto del titulo en blanco
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; //Texto de los botones en blanco
    
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor colorWithRed:.92 green:0.92 blue:0.92 alpha:0.8]];
    
   

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Lo primero es generar nuestro array de vans con una clase constructora de ayuda
    // self.vansArray = [EQLGarageModel allVans];
    
    
   // NSLog(@"ejecutamos el constructor");
    self.garage = [[EQLGarageModel alloc]init];
    
    
    //self.vansArray = _garage.allVans;
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 3;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
 
    switch (indexPath.row){
        case 0:
            cell.textLabel.text = @"Catalogo de Remolques";
            cell.detailTextLabel.text = @"Explore todos los modelos de Cheval Liberte";
            break;
        case 1:
            cell.textLabel.text = @"¿Qué VAN puedo llevar con mi carné?";
            cell.detailTextLabel.text = @"Aclarese con los carnés";
            break;
        default:
            break;
            
    }
    //cadena = @"MMA:";
    //cell.imageView.image = ;
 
    return cell;
}
*/

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
    if ([sender isKindOfClass:[UITableViewCell class]]){
        
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceFormViewController class]]){
            EQLLicenceFormViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.garage;
            //We pass the fulfiled array with all the vans inside.
        } else if ([segue.destinationViewController isKindOfClass:[EQLCatalogTableViewController class]]){
            EQLCatalogTableViewController *nextViewController = segue.destinationViewController;
            nextViewController.model = self.garage;
            //We pass the fulfiled array with all the vans inside.
        }
        
    }
    
}


@end
