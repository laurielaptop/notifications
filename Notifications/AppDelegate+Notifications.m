//
//  AppDelegate+Notifications.m
//  Notifications
//
//  Created by Laurie Laptop on 22/01/2022.
//

#import "AppDelegate+Notifications.h"
#import "NSString+Utilities.h"

@implementation AppDelegate (Notifications)

- (void)registerPush {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions: (UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler: ^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        });
    }];
}

- (void)didRegisterPush:(NSString*)token {
    NSLog(@"%s token: %@ %@", __PRETTY_FUNCTION__, token, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    NSString *message1 = @"App registered.";
    NSString *message2 = [NSString stringWithFormat:@"Token: %@", token];
    NSDictionary *info = @{@"message1":message1, @"message2":message2};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveMessage" object:nil userInfo:info];
}

- (void)didNotRegisterPush:(NSError *)error {
    NSLog(@"%s error: %@ %@", __PRETTY_FUNCTION__, error.localizedDescription, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    NSString *message1 = @"App NOT registered.";
    NSString *message2 = [NSString stringWithFormat:@"Error: %@", error.localizedDescription];
    NSDictionary *info = @{@"message1":message1, @"message2":message2};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveMessage" object:nil userInfo:info];
}

- (void)didReceiveRemotePush:(NSDictionary*)userInfo {
    NSLog(@"%s userInfo: %@ %@", __PRETTY_FUNCTION__, userInfo, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    NSString *message1 = @"Received remote push.";
    NSString *message = userInfo[@"message"];
    NSString *message2 = [NSString stringWithFormat:@"Message: %@", message != nil ? message : @"** NO MESSAGE **"];
    NSDictionary *info = @{@"message1":message1, @"message2":message2};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveMessage" object:nil userInfo:info];
}

- (void)didReceivePushResponse:(NSDictionary*)userInfo {
    NSLog(@"%s userInfo: %@ %@", __PRETTY_FUNCTION__, userInfo, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    NSString *message1 = @"Received push response.";
    NSString *message = userInfo[@"message"];
    NSString *message2 = [NSString stringWithFormat:@"Message: %@", message != nil ? message : @"** NO MESSAGE **"];
    NSDictionary *info = @{@"message1":message1, @"message2":message2};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveMessage" object:nil userInfo:info];
}

- (void)didReceiveSilentPush:(NSDictionary*)userInfo {
    NSLog(@"%s userInfo: %@ %@", __PRETTY_FUNCTION__, userInfo, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    NSInteger badgeNumber = [userInfo[@"badgeNumber"] integerValue]; // 'badgeNumber' is a custom field. Don't confuse it with the aps 'badge' value.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
    NSString *message1 = @"The app received a background push.";
    NSString *message = userInfo[@"message"];
    NSString *message2 = [NSString stringWithFormat:@"Badge: %ld. Message: %@", badgeNumber, message != nil ? message : @"** NO MESSAGE **"];
    NSDictionary *info = @{@"message1":message1, @"message2":message2};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveMessage" object:nil userInfo:info];
}

#pragma mark UNNotificationCenter

/*  The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.

 Example APNS payload for remote push:
 
 {
     "aps" : {
      "alert" : "Testing push notifications",
      "badge" : 1,
      "sound" : "o.caf"
     },
     "foo" : "bar"
 }
 */

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    [self didReceiveRemotePush:notification.request.content.userInfo];
    completionHandler((UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge));
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    [self didReceivePushResponse:response.notification.request.content.userInfo];
    completionHandler();
}

#pragma mark UIApplicationDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    NSString *token = [NSString stringFromDeviceToken:deviceToken];
    [self didRegisterPush:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    [self didNotRegisterPush:error];
}

/* This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented.
 
 Example APNS payload for silent push:
 
 {
     "aps": {
         "content-available": 1
     },
     "badgeNumber": 7
 }
*/

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    [self didReceiveSilentPush:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

@end
