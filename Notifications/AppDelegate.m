//
//  AppDelegate.m
//  Notifications
//
//  Created by Laurie Laptop on 19/01/2022.
//

#import "AppDelegate.h"
#import "AppDelegate+Notifications.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; // Reset badge and notifications
    [self registerPush];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
}

@end
