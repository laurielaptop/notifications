//
//  AppDelegate+Notifications.h
//  Notifications
//
//  Created by Laurie Laptop on 22/01/2022.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Notifications) <UNUserNotificationCenterDelegate>

- (void)registerPush;

@end

NS_ASSUME_NONNULL_END
