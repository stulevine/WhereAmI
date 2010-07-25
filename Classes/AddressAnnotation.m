//
//  AddressAnnotation.m
//  WhereAmI
//
//  Created by Stuart Levine on 3/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation

@synthesize coordinate;
@synthesize mTitle;
@synthesize mSubTitle;

- (NSString *)subtitle{
	return mSubTitle;
}

- (NSString *)title{
	return mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}

@end