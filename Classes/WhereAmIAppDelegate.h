//
//  WhereAmIAppDelegate.h
//  WhereAmI
//
//  Created by Stuart Levine on 3/31/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WhereAmIViewController;

@interface WhereAmIAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    WhereAmIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WhereAmIViewController *viewController;

@end

