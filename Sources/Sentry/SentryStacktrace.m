//
//  SentryStacktrace.m
//  Sentry
//
//  Created by Daniel Griesser on 05/05/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//


#if __has_include(<Sentry/Sentry.h>)
#import <Sentry/SentryStacktrace.h>
#import <Sentry/SentryFrame.h>
#else
#import "SentryStacktrace.h"
#import "SentryFrame.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@implementation SentryStacktrace

- (instancetype)initWithFrames:(NSArray<SentryFrame *> *)frames registers:(NSDictionary<NSString *,NSString *> *)registers {
    self = [super init];
    if (self) {
        self.registers = registers;
        self.frames = frames;
    }
    return self;
}

- (NSDictionary<NSString *,id> *)serialized {
    NSMutableDictionary *serializedData = [NSMutableDictionary new];
    
    NSMutableArray *frames = [NSMutableArray new];
    for (SentryFrame *frame in self.frames) {
        [frames addObject:frame.serialized];
    }
    [serializedData setValue:frames forKey:@"frames"];
    
    // This is here because we wanted to be conform with the old json
    if (self.registers.count > 0) {
        [serializedData setValue:self.registers forKey:@"registers"];
    }
    return serializedData;
}

@end

NS_ASSUME_NONNULL_END
