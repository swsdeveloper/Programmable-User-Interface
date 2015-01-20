//
//  AppDelegate.m
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/16/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //NSLog(@"in application:didFinishLaunchingWithOptions:");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.viewController = [[MyViewController alloc] initWithNibName:@"View" bundle:nil];
    
    self.window.rootViewController = self.viewController;
    
    self.window.backgroundColor = [UIColor yellowColor];
    
    //NSLog(@"\nabout to invoke makeKeyAndVisible");
    
    [self.window makeKeyAndVisible];
    
    //NSLog(@"\nback in application:didFinishLaunchingWithOptions - after makeKeyAndVisible");
    
    if (MYDEBUG) {
        CGFloat boundsX = self.window.bounds.origin.x;     // CGFloat -> float
        CGFloat boundsY = self.window.bounds.origin.x;
        CGFloat boundsWidth = self.window.bounds.size.width;
        CGFloat boundsHeight = self.window.bounds.size.height;
        
        NSLog(@"\nWindow Bounds: x:%f, y:%f, w:%f, h:%f\n", boundsX, boundsY, boundsWidth, boundsHeight);  // 0, 0, 768, 1024
    }
    
    NSLog(@"orientation:%d", (int)[[UIDevice currentDevice] orientation]);
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
