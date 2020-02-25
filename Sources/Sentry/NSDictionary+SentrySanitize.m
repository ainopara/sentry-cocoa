//
//  NSDictionary+SentrySanitize.m
//  Sentry
//
//  Created by Daniel Griesser on 16/06/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//

#if __has_include(<Sentry/Sentry.h>)

#import <Sentry/NSDictionary+SentrySanitize.h>
#import <Sentry/NSArray+SentrySanitize.h>
#import <Sentry/NSDate+SentryExtras.h>

#else
#import "NSDictionary+SentrySanitize.h"
#import "NSArray+SentrySanitize.h"
#import "NSDate+SentryExtras.h"
#endif

@implementation NSDictionary (SentrySanitize)

- (NSDictionary *)sentry_sanitize {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id rawKey in self.allKeys) {
        id rawValue = [self objectForKey:rawKey];

        NSString *stringKey;
        if ([rawKey isKindOfClass:NSString.class]) {
            stringKey = rawKey;
        } else {
            stringKey = [rawKey description];
        }

        if ([stringKey hasPrefix:@"__sentry"]) {
            continue; // We don't want to add __sentry variables
        }

        if ([rawValue isKindOfClass:NSString.class]) {
            [dict setValue:rawValue forKey:stringKey];
        } else if ([rawValue isKindOfClass:NSNumber.class]) {
            [dict setValue:rawValue forKey:stringKey];
        } else if ([rawValue isKindOfClass:NSDictionary.class]) {
            [dict setValue:[(NSDictionary *)rawValue sentry_sanitize] forKey:stringKey];
        } else if ([rawValue isKindOfClass:NSArray.class]) {
            [dict setValue:[(NSArray *)rawValue sentry_sanitize] forKey:stringKey];
        } else if ([rawValue isKindOfClass:NSDate.class]) {
            [dict setValue:[(NSDate *)rawValue sentry_toIso8601String] forKey:stringKey];
        } else {
            // rawValue probably can not be converted to json
            [dict setValue:[rawValue description] forKey:stringKey];
        }
    }
    return dict;
}

@end
