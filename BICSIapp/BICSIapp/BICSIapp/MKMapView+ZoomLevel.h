//
//  MKMapView+ZoomLevel.h
//  BICSIapp
//
//  Created by Barry on 4/26/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end
