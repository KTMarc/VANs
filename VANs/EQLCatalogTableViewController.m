//
//  EQLCatalogTableViewController.m
//  VAN Selector
//
//  Created by Marc Humet on 04/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLCatalogTableViewController.h"
#import "EQLVanViewController.h"
#import "EQLGarageModel.h"
#import "EQLPriceView.h"
#import "EQLNumHorsesView.h"
#import "EQLSuspensionIcon.h"
#import "EQLPlancherIcon.h"
#import "EQLVistoView.h"
#import "EQLLicenceForm1ViewController.h"

@interface EQLCatalogTableViewController ()

@end

@implementation EQLCatalogTableViewController


#pragma mark - Parse

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"modeloVan";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"Name";
        
        // The title for this table in the Navigation Controller.
        self.title = @"Catálogo";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 15;
        
        //First time we load we want to load from the server
        self.shouldUpdateFromServer= true;
        
        //Creamos nuestro modelo una sola vez
        self.model = [[EQLGarageModel alloc]init];
        
        //Bajamos los vans de la red si no los tenemos en el localDataStore.
        //[self.model doAsyncQueryToParse:false];
    }
    return self;
}


- (void)updateGarage{
    //PFQueryTableView already downloaded an array with all information and now we need to assign it to our model.
    //This is done to get rid of Parse at some point and use another backend
    self.model.allVans = [self.objects mutableCopy];
    [self.model separateVansByNumberOfHorses];
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    // This method is called every time objects are loaded from Parse via the PFQuery
    //NSLog(@"Downloaded %lu objects from Parse",  (unsigned long)[self.objects count]);
    
    // If we just updated from the server, do nothing, otherwise update from server.
    if (self.shouldUpdateFromServer) {
        [self refreshLocalDataStoreFromServer];
    } else {
        //MH: We leave this as true for the next time we are in this callback. We assume that the next time we will want to update the datastore from data form the network
        self.shouldUpdateFromServer = true;
    }
    
    [self updateGarage];
    
    // Only to know the number of rows in each section
    if (!self.executionFlag){
        for (id van in self.objects){
            // NSLog(@"Entra al for");
            int numHorsesInPFObject = [van[@"horsesNum"] intValue];
            switch (numHorsesInPFObject) {
                case 1:
                    _oneHorseCount++;
                    break;
                case 2:
                    _twoHorseCount++;
                    break;
                case 3:
                    _threeHorseCount++;
                    break;
                case 4:
                    _fourHorseCount++;
                    break;
                default:
                    break;
            }
        }
        self.executionFlag = YES;
    }

//     NSLog(@" Recuento 1 caballo: %d", _oneHorseCount);
//     NSLog(@" Recuento 2 caballos: %d", _twoHorseCount);
//     NSLog(@" Recuento 3 caballos: %d", _threeHorseCount);
//     NSLog(@" Recuento 4 caballos: %d", _fourHorseCount);
    
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    // This method is called before a PFQuery is fired to get more objects
    
    self.executionFlag = NO;
    _oneHorseCount = 0;
    _twoHorseCount = 0;
    _threeHorseCount = 0;
    _fourHorseCount = 0;
}

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.

- (PFQuery *)queryForTable {
    //PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    // tell the query to fetch all of the Weapon objects along with the user
    // get the "many" at the same time that you're getting the "one"
 //   [query includeKey:@"photosArray"];
    
    //Esto es lo pone en la superclase PFQueryViewController:
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
   //Asi pues ya controla si se han cargado objetos la vez anterior y si estamos usando localDatastore. Si usamos local Datastore no podemos usar las cachepolicy!!
    //Como ya hemos hecho el acceso a la red en el EQLGarageModel ya nos ha guardado en el Datastore los datos. Y si intentamos acceder al catalogo sin red, aun funciona.
    // [query fromLocalDatastore];
    // [query orderByAscending:@"Priority"];
    // [query whereKey:@"enabled" equalTo:@(YES)];
    // return query;
    return [[self baseQuery] fromLocalDatastore];
}


- (void)refreshLocalDataStoreFromServer
{
    [[[self baseQuery] findObjectsInBackground] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            [self.refreshControl endRefreshing];
            return nil;
        }
        return [[PFObject unpinAllObjectsInBackgroundWithName:@"modeloVan"] continueWithSuccessBlock:^id(BFTask *unused) {
            NSArray *objects = task.result;
            return [[PFObject pinAllInBackground:objects withName:@"modeloVan"] continueWithSuccessBlock:^id(BFTask *unused) {
                [self.refreshControl endRefreshing];
                [self loadObjects];
                _shouldUpdateFromServer = false;
                return nil;
            }];
        }];
    }];
}

- (PFQuery *)baseQuery {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query orderByAscending:@"Priority"];
    [query whereKey:@"enabled" equalTo:@(YES)];
    return query;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBarHidden = FALSE;
//    self.tableView.allowsSelection = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255./255.0 green:102.0/255.0 blue:102/255.0 alpha:1.0]; //Fondo rojo equus
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; //Texto de los botones en blanco

    self.navigationController.hidesBarsOnSwipe = false;
    self.navigationController.hidesBarsOnTap = false;
    self.navigationController.hidesBarsWhenVerticallyCompact = false;
    self.navigationController.navigationBarHidden = false;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"catalogCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //To avoid the fade to grey once we select it.
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
#pragma mark: TODO - Filter cells when checking licence needed.
    //To display dimmed the cells of the trailers that cannot be driven because of something
    //cell.contentView.alpha = 0.5;
    
    
    // Configure the cell
    
    PFFile *thumbnailFile = [object objectForKey:@"photo"];
    PFImageView *thumbnailImageView = [[PFImageView alloc] init];
    thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.png"];
    thumbnailImageView.file = thumbnailFile;
    [thumbnailImageView loadInBackground];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [object objectForKey:@"Name"];
    
    UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
    prepTimeLabel.text = [object objectForKey:@"price"];
    
    EQLPriceView *priceView = (EQLPriceView *) [cell viewWithTag:103];
    priceView.price = [object objectForKey:@"price"];
    
    EQLNumHorsesView *numhorsesView = (EQLNumHorsesView *) [cell viewWithTag:104];
    numhorsesView.numHorses = [[object objectForKey:@"horsesNum"] stringValue];
    
    UILabel *suspensionLabel = (UILabel*) [cell viewWithTag:107];
    EQLVistoView *vistoView = (EQLVistoView *) [cell viewWithTag:108];
    vistoView.hidden = true;
    
    if ([[object objectForKey:@"pullman"] boolValue]){
        /*Icono massa gran per posar aqui
         EQLsuspensionIcon *suspensionView = (EQLsuspensionIcon *) [cell viewWithTag:105];
         suspensionView.suspension = [[object objectForKey:@"pullman"] boolValue];
         */
        vistoView.hidden = false;
        suspensionLabel.text = @"Suspensión";
        
    } else {
        suspensionLabel.hidden = true;
    }
    
    /*
     EQLplancherIcon *plancherView = (EQLplancherIcon *) [cell viewWithTag:106];
     plancherView.sueloAluminio = [[object objectForKey:@"plancherAlu"] boolValue];
     */
    
    return cell;
}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSUInteger count = 0;
    
    if (section == ONE_HORSE_SECTION) {
        count = _oneHorseCount;
    
    }else if (section == TWO_HORSE_SECTION) {
        count = _twoHorseCount;
    }else if (section == THREE_HORSE_SECTION) {
        count = _threeHorseCount;
    }
    else {
        count = _fourHorseCount;
    }
    
    return count;
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

 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - Table view data source

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
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    self.parseVanOrigen = [self.objects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"comingFromCatalog" sender:self.parseVanOrigen];
   // NSLog(@"%@", self.parseVanOrigen[@"Name"]);
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([segue.destinationViewController isKindOfClass:[EQLVanViewController class]]){
            //We pass the array of pictures, not the vanObject
            EQLVanViewController *nextViewController = segue.destinationViewController;
            nextViewController.parseVan = sender;
        }
    
        if ([segue.destinationViewController isKindOfClass:[EQLLicenceForm1ViewController class]]){
            EQLLicenceForm1ViewController *nextViewController = segue.destinationViewController;
            NSLog(@"Entramos en el preparforsegue del formulario PASO A PASO");
            //We pass the fulfiled array with all the vans inside.
            nextViewController.model = self.model;
            NSLog(@"Tenemos este modelo cuando vamos a pasar al formulario:%@", self.model);
        
    }
}

@end