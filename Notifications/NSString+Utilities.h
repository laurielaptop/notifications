//
//  NSString+Utilities.h
//  Notifications
//
//  Created by Laurie Laptop on 23/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utilities)

+ (NSString *)stringFromDeviceToken:(NSData *)deviceToken;
- (NSDictionary *)JSONStringToDictionary;

@end

NS_ASSUME_NONNULL_END
