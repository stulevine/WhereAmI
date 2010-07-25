//
//  WhereAmIViewController.h
//  WhereAmI
//
//  Created by Stuart Levine on 3/31/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <Mapkit/MKPinAnnotationView.h>
#import <MapKit/MKPlacemark.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>

@interface WhereAmIViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, MKReverseGeocoderDelegate> {
	CLLocationManager	*locationManager;
	CLLocation			*startingPoint;
	MKMapView			*mapView;
    MKReverseGeocoder	*reverseGeocoder;
	MKPlacemark			*mPlacemark;
	UILabel				*latlongLabel;
	UILabel				*horizontalAccuracyLabel;
	UILabel				*altitudeLabel;
	UILabel				*verticalAccuracyLabel;
	UILabel				*distanceTraveledLabel;
}
	
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) CLLocation *startingPoint;
@property (retain, nonatomic) MKReverseGeocoder *reverseGeocoder;
@property (retain, nonatomic) MKPlacemark *mPlacemark;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UILabel *latlongLabel;
@property (retain, nonatomic) IBOutlet UILabel *horizontalAccuracyLabel;
@property (retain, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *verticalAccuracyLabel;
@property (retain, nonatomic) IBOutlet UILabel *distanceTraveledLabel;

@end

