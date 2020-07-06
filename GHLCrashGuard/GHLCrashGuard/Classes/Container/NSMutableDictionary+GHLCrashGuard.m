//
//  NSMutableDictionary+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/11.
//

#import "NSMutableDictionary+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSMutableDictionary (GHLCrashGuard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSDictionaryM") jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(guard_setObject:forKey:) error:nil];
        [NSClassFromString(@"__NSDictionaryM") jr_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(guard_setObject:forKeyedSubscript:) error:nil];
        [NSClassFromString(@"__NSDictionaryM") jr_swizzleMethod:@selector(removeObjectForKey:) withMethod:@selector(guard_removeObjectForKey:) error:nil];
    });
}

- (void)guard_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!anObject || !aKey) {
        // 收集堆栈，上报 Crash
        return;
    }
    [self guard_setObject:anObject forKey:aKey];
}

- (void)guard_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
        // 收集堆栈，上报 Crash
        return;
    }
    [self guard_setObject:obj forKeyedSubscript:key];
}

- (void)guard_removeObjectForKey:(id)aKey {
    if (!aKey) {
        // 收集堆栈，上报 Crash
        return;
    }
    [self guard_removeObjectForKey:aKey];
}

@end
