//
//  mapViewController.h
//  WhereAmI
//
//  Created by Stuart Levine on 3/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>


@interface mapViewController : UIViewController {
	NSString	*passedAddress;
	NSString	*nameLabel;
	MKMapView	mapView;
}

@property (retain, nonatomic) NSString *passedAddress;
@property (retain, nonatomic) NSString *nameLabel;

@end
