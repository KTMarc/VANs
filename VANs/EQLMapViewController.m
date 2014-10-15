//
//  DVDViewController.m
//  PutoMapa2
//
//  Created by David on 20/09/14.
//  Copyright (c) 2014 torguet. All rights reserved.
//
@import MapKit;
#import "EQLMapViewController.h"



@interface EQLMapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (strong,nonatomic) NSArray *points;
@property (assign, nonatomic) BOOL automaticRegionRunning;
@property (assign, nonatomic) BOOL firstLocation;
@property (strong, nonatomic) NSDate *lastUpdate;
@property (strong, nonatomic) CLLocation *lastLocation;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, strong) MKPolyline *objPolyline;
@property (nonatomic, strong) NSArray *places;
@property (assign, nonatomic) BOOL savingRoute;
@property (strong, nonatomic) NSMutableArray *track;
@property (assign, nonatomic) BOOL userUpdatedMap;
//@property (strong, nonatomic) NSMutableArray *overlays;


@end

@implementation EQLMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.lastUpdate = [NSDate dateWithTimeIntervalSince1970:0];
      //  self.lastLocation = [[CLLocation alloc] initWithLatitude:40.41f longitude:3.68f];
        self.firstLocation = YES;
        self.savingRoute = NO;
        self.automaticRegionRunning = NO;
        self.userUpdatedMap = NO;
        self.track = [NSMutableArray new];
        self.localSearch = [MKLocalSearch new];

    }
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = FALSE;
    
    //anotar puntos en el mapa
    MKPointAnnotation *poin0 =[[MKPointAnnotation alloc] init];
    poin0.title = @"EQUUS LIFE";
    poin0.subtitle = @"Santa Perpetua de M., Barcelona (93112394)";
    poin0.coordinate = CLLocationCoordinate2DMake(41.533635,2.168644);
    //[self.mapView addAnnotation:poin0];
    
    MKPointAnnotation *poin1 =[[MKPointAnnotation alloc] init];
    poin1.title = @"COMERCIAL DE SENRA";
    poin1.subtitle = @"Ortigueira, La Coruña";
    poin1.coordinate = CLLocationCoordinate2DMake(43.683091,-7.895631);

    //[self.mapView addAnnotation:poin1];
    
    MKPointAnnotation *poin2 =[[MKPointAnnotation alloc] init];
    poin2.title = @"SA COOPERATIVA";
    poin2.subtitle = @"Ciutadella (Menorca)";
    poin2.coordinate = CLLocationCoordinate2DMake(40.009806,3.855797);

    
    MKPointAnnotation *poin3 =[[MKPointAnnotation alloc] init];
    poin3.title = @"DISTRIBUCIONES LUCERO";
    poin3.subtitle = @" (junto a la rotonda M-501 km 17) Entrada por la M-600 Km 37, Brunete, Madrid";
    poin3.coordinate = CLLocationCoordinate2DMake(40.391578, -3.993370);
    
    MKPointAnnotation *poin4 =[[MKPointAnnotation alloc] init];
    poin4.title = @"FEPAN";
    poin4.subtitle = @"C/ Virgen de Loreto, 41 - Bajo Acc.B - 41011, Sevilla";
    poin4.coordinate = CLLocationCoordinate2DMake(37.375610, -5.999798);

    MKPointAnnotation *poin5 =[[MKPointAnnotation alloc] init];
    poin5.title = @"AGROMUSKIZ";
    poin5.subtitle = @"El Crucero 35, antiguo edificio La Casera (San Juan)48550 Muskiz 946 708 321";
    poin5.coordinate = CLLocationCoordinate2DMake(43.323215, -3.112760);
    
    [self.mapView addAnnotations:@[poin0, poin1, poin2, poin3, poin4, poin5]];
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    self.title = @"Distribuidores";
    [self centerLocationWithPoint:[[CLLocation alloc] initWithLatitude:40.435737 longitude: -2.180311] andDelta:12.7];
    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate = self;
    
    
    //CLLocation *initPoint = [CLLocation new];
    //[self centerLocationWithPoint:initPoint andDelta:0.015];
}

- (void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)centerLocationWithPoint:(CLLocation *)location{
    //MKCoordinateRegion viewRegion = [self RegionForAnnotations:self.arrayPois];
    //PRPAppDelegate *appDel = (PRPAppDelegate *)[UIApplication sharedApplication].delegate;
    self.automaticRegionRunning = YES;
    MKCoordinateRegion region;
    region = _mapView.region;
    region.center.latitude = location.coordinate.latitude;
    region.center.longitude = location.coordinate.longitude;
    [_mapView setRegion:region animated:YES];
}

- (void)centerLocationWithPoint:(CLLocation *)location andDelta:(CGFloat)delta{
    self.automaticRegionRunning = YES;
    MKCoordinateRegion region;
    region.center.latitude = location.coordinate.latitude;
    region.center.longitude = location.coordinate.longitude;
    region.span.latitudeDelta = delta;
    region.span.longitudeDelta = delta;
    [_mapView setRegion:region animated:YES];
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    self.automaticRegionRunning = YES;
    CLLocationCoordinate2D loc= [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 450, 450);
    [mapView setRegion:region animated:YES];
    
}



#pragma mark - MKMapViewDelegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // No modificamos UserLocation
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    //static NSString *annotationIdentifier = @"MyLocation";
    static NSString *annotationIdentifier = @"";
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if (!annotationView) {
        
        annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"map_marker.png"];// Here we use a nice image instead of the default pins
        } else {
            annotationView.annotation = annotation;
        }
    }
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Pulsado POI: %@", view);
    
    //[self presentPopupViewController:popUpViewController animationType:MJPopupViewAnimationSlideBottomBottom];
}

- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated{
    //NSLog(@"Deltalong: %f", aMapView.region.span.longitudeDelta);
    if (self.automaticRegionRunning) {
        self.automaticRegionRunning = NO;
    }else{
        self.userUpdatedMap = YES;
    }
}

// http://stackoverflow.com/questions/2834523/drawing-a-route-in-mapkit-in-iphone-sdk
/* MKMapViewDelegate Meth0d -- for viewForOverlay*/
- (MKOverlayView*)mapView:(MKMapView*)theMapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineView *view = [[MKPolylineView alloc] initWithPolyline:self.objPolyline];
    view.fillColor = [UIColor blackColor];
    view.strokeColor = [UIColor blackColor];
    view.lineWidth = 4;
    //[self.overlays addObject:view];
    return view;
}


@end
