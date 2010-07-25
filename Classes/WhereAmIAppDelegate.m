//
//  WhereAmIAppDelegate.m
//  WhereAmI
//
//  Created by Stuart Levine on 3/31/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WhereAmIAppDelegate.h"
#import "WhereAmIViewController.h"

@implementation WhereAmIAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
