//
//  NSArray+SentrySanitize.m
//  Sentry
//
//  Created by Zheng Li on 2020/2/25.
//  Copyright © 2020 Sentry. All rights reserved.
//

#if __has_include(<Sentry/Sentry.h>)

#import <Sentry/NSArray+SentrySanitize.h>
#import <Sentry/NSDictionary+SentrySanitize.h>
#import <Sentry/NSDate+SentryExtras.h>

#else
#import "NSArray+SentrySanitize.h"
#import "NSDictionary+SentrySanitize.h"
#import "NSDate+SentryExtras.h"
#endif

@implementation NSArray (SentrySanitize)

- (NSArray *)sentry_sanitize {
    NSMutableArray *array = [NSMutableArray array];
    for (id rawValue in self) {

        if ([rawValue isKindOfClass:NSString.class]) {
            [array addObject:rawValue];
        } else if ([rawValue isKindOfClass:NSNumber.class]) {
            [array addObject:rawValue];
        } else if ([rawValue isKindOfClass:NSDictionary.class]) {
            [array addObject:[(NSDictionary *)rawValue sentry_sanitize]];
        } else if ([rawValue isKindOfClass:NSArray.class]) {
            [array addObject:[(NSArray *)rawValue sentry_sanitize]];
        } else if ([rawValue isKindOfClass:NSDate.class]) {
            [array addObject:[(NSDate *)rawValue sentry_toIso8601String]];
        } else {
            // rawValue probably can not be converted to json
            [array addObject:[rawValue description]];
        }
    }
    return array;
}

@end
