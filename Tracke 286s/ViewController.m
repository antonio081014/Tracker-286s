//
//  ViewController.m
//  Tracke 286s
//
//  Created by Antonio081014 on 4/7/14.
//  Copyright (c) 2014 Antonio081014.com. All rights reserved.
//

#import "ViewController.h"
@import MapKit;
#import "MAnnotation.h"
#import "MAnnotationView.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController

#define METERS_PER_MILE 1609.344
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;
    
    // Set the center of the map.
    // This is the Park near Los Angeles City Hall.
    CLLocationCoordinate2D centerLocation;
    centerLocation.latitude = 34.0528873;
    centerLocation.longitude = -118.2434255;
    // Create a Map Region based on the Center Location created above and the size defined below.
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(centerLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // Set the Map Region to display.
    [self.mapView setRegion:viewRegion animated:YES];
    
    // Create the coordinate for the Annotation.
    // This is the location of Los Angeles City Hall, which could be fetched from Google Map.
    CLLocationCoordinate2D coordinateOfLACityHall;
    coordinateOfLACityHall.latitude = 34.053714;
    coordinateOfLACityHall.longitude = -118.242653;
    
    // Create the Annotation with our designate initializer.
    MAnnotation *annotation = [[MAnnotation alloc] initWithLocation:coordinateOfLACityHall andAngle:90.f];
    // Add the annotation to the Map.
    [self.mapView addAnnotation:annotation];
}

- (IBAction)clearAllAnnotations:(UIBarButtonItem *)sender
{
    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // If this annotation is our custom define annotation, we'll display it in our custom annotation view.
    if ([annotation isKindOfClass:[MAnnotation class]]) {
        
        static NSString *annotationViewIdentifier = @"Custom Annotation View";
        // We retrieve this annotation view.
        MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
        
        // If it has been used before, we update the annotation information, so the view could be redraw.
        if (annotationView) {
            annotationView.annotation = (MAnnotation *)annotation;
        }
        // Otherwise, let's create it.
        else {
            annotationView = [[MAnnotationView alloc] initWithAnnotation:(MAnnotation *)annotation
                                                         reuseIdentifier:annotationViewIdentifier];
            annotationView.opaque = NO;
        }
        return annotationView;
    }
    // Otherwise, will use annotation's default annotation view to display it.
    // For user current location, it will be a blue twinkle ball.
    // For other location, it will be a red point pin.
    return nil;
}

@end
