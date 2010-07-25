//
//  WhereAmIViewController.m
//  WhereAmI
//
//  Created by Stuart Levine on 3/31/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WhereAmIViewController.h"
#import "AddressAnnotation.h"

@implementation WhereAmIViewController
@synthesize locationManager;
@synthesize startingPoint;
@synthesize mapView;
@synthesize reverseGeocoder;
@synthesize mPlacemark;
@synthesize latlongLabel;
@synthesize horizontalAccuracyLabel;
@synthesize altitudeLabel;
@synthesize verticalAccuracyLabel;
@synthesize distanceTraveledLabel;

#pragma mark -
- (void)viewDidLoad {
	//self.startingPoint = nil;
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[self.locationManager startUpdatingLocation];	
	//self.mapView.showsUserLocation = TRUE;
	self.mapView.delegate = self;

}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.locationManager = nil;
	self.latlongLabel = nil;
	self.horizontalAccuracyLabel = nil;
	self.altitudeLabel = nil;
	self.verticalAccuracyLabel = nil;
	self.distanceTraveledLabel = nil;
	self.startingPoint = nil;
	self.mapView = nil;
	self.reverseGeocoder = nil;
	self.mPlacemark = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[locationManager release];
	[startingPoint release];
	[latlongLabel release];
	[horizontalAccuracyLabel release];
	[altitudeLabel release];
	[verticalAccuracyLabel release];
	[distanceTraveledLabel release];
	[mapView release];
	[reverseGeocoder release];
	[mPlacemark release];
    [super dealloc];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager
			didUpdateToLocation:(CLLocation *)newLocation
			fromLocation:(CLLocation *)oldLocation {
	
	if (startingPoint == nil)
		self.startingPoint = newLocation;
	
	NSString *latlongStrng = [[NSString alloc] initWithFormat:@"%g°, %g°",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
	latlongLabel.text = latlongStrng;
	[latlongStrng release];
	
	NSString *horizontalAccuracyString = [[NSString alloc] initWithFormat:@"%gm",newLocation.horizontalAccuracy];
	horizontalAccuracyLabel.text = horizontalAccuracyString;
	[horizontalAccuracyString release];
	
	NSString *altitudeString = [[NSString alloc] initWithFormat:@"%gm",newLocation.altitude];
	altitudeLabel.text = altitudeString;
	[altitudeString release];
	
	NSString *verticalAccuracyString = [[NSString alloc] initWithFormat:@"%gm",newLocation.verticalAccuracy];
	verticalAccuracyLabel.text = verticalAccuracyString;
	[verticalAccuracyString release];
	
	CLLocationDistance distance = [newLocation getDistanceFrom:startingPoint];
	NSString *distanceString = [[NSString alloc] initWithFormat:@"%gm", distance];
	distanceTraveledLabel.text = distanceString;
	[distanceString release];	

	self.reverseGeocoder =
	[[[MKReverseGeocoder alloc] initWithCoordinate:mapView.userLocation.location.coordinate] autorelease];
	[reverseGeocoder initWithCoordinate:newLocation.coordinate];
	reverseGeocoder.delegate = self;
	[reverseGeocoder start];
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.01;
	span.longitudeDelta = 0.01;
	region.span = span;
	region.center = newLocation.coordinate;
	
	//AddressAnnotation *annotation = [[AddressAnnotation alloc] initWithCoordinate:newLocation.coordinate];
	//annotation.mTitle = [[NSString alloc] initWithString:@"You are here"];
    //annotation.mSubTitle = [[NSString alloc] initWithString:@"somewhere"];;
	
	//[mapView addAnnotation:annotation];
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting Location" message:errorType delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(-5, 5);
    return annView;
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	NSLog(@"Reverse Geocoder Errored");
	
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	NSLog(@"Reverse Geocoder completed");
	mPlacemark=placemark;
	AddressAnnotation *annotation = [[AddressAnnotation alloc] initWithCoordinate:startingPoint.coordinate];
	annotation.mTitle = placemark.thoroughfare;
    annotation.mSubTitle = placemark.postalCode;
	[mapView addAnnotation:annotation];
}


@end
