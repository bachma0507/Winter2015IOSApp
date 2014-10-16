//
//  BICSImapViewController.m
//  BICSIapp
//
//  Created by Barry on 4/24/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import "BICSImapViewController.h"
#import "MKMapView+ZoomLevel.h"

#define BICSI_LATITUDE 28.076970
#define BICSI_LONGITUDE -82.362925

#define ZOOM_LEVEL 14

@interface BICSImapViewController ()

@end

@implementation BICSImapViewController
@synthesize mapView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CLLocationCoordinate2D centerCoord = { BICSI_LATITUDE, BICSI_LONGITUDE };
    [mapView setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:NO];
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = centerCoord;
    annotationPoint.title = @"BICSI Headquarters";
    annotationPoint.subtitle = @"8610 Hidden River Pkwy, Tampa FL 33637";
    [mapView addAnnotation:annotationPoint];
    
    [mapView selectAnnotation:annotationPoint animated:NO];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /*CLLocationCoordinate2D annotationCoord;
    
        
    annotationCoord.latitude = 28.076970;
    annotationCoord.longitude = -82.362925;
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = @"BICSI Headquarters";
    annotationPoint.subtitle = @"8610 Hidden River Pkwy, Tampa FL 33637";
    [mapView addAnnotation:annotationPoint];
    
    self.mapView.delegate = self;*/
    
    
    
    
    
}

/*- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];*/
    
    // Add an annotation
    /*MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
}*/
/*- (void)zoomIn: (id)sender
{
    MKUserLocation *userLocation = mapView.userLocation;
    MKCoordinateRegion region =MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 50, 50);
    [mapView setRegion:region animated:YES];
    
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
