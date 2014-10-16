//
//  BICSImapViewController.h
//  BICSIapp
//
//  Created by Barry on 4/24/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BICSImapViewController : UIViewController <MKMapViewDelegate> {
    
    IBOutlet MKMapView *mapView;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
