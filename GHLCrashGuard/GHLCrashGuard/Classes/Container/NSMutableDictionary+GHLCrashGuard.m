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
    
    [NSClassFromString(@"__NSDictionaryM") jr_swizzleMethod:@selector(removeObjectForKey:) withMethod:@selector(guard_removeObjectForKey:) error:nil];
    [NSClassFromString(@"__NSDictionaryM") jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(guard_setObject:forKey:) error:nil];
}

- (void)guard_removeObjectForKey:(id)aKey {
    if (!aKey) {
        return;
    }
    [self guard_removeObjectForKey:aKey];
}

- (void)guard_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    [self guard_setObject:anObject forKey:aKey];
}

@end
