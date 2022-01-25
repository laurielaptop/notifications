//
//  NSString+Utilities.m
//  Notifications
//
//  Created by Laurie Laptop on 23/01/2022.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)

+ (NSString *)stringFromDeviceToken:(NSData *)deviceToken {
    const char *data = [deviceToken bytes];
    NSMutableString *token = [NSMutableString string];
    for (NSUInteger i = 0; i < [deviceToken length]; i++) {
        [token appendFormat:@"%02.2hhX", data[i]];
    }
    return [token copy];
}

- (NSDictionary *)JSONStringToDictionary {
    NSError *error;
    NSData *objectData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&error];
    return (!json ? nil : json);
}

@end
