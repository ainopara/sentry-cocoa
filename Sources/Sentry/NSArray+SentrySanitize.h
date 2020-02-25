//
//  NSArray+SentrySanitize.h
//  Sentry
//
//  Created by Zheng Li on 2020/2/25.
//  Copyright © 2020 Sentry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SentrySanitize)

- (NSArray *)sentry_sanitize;

@end


NS_ASSUME_NONNULL_END
