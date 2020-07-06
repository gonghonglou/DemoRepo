//
//  NSMutableArray+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/11.
//

#import "NSMutableArray+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSMutableArray (GHLCrashGuard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSArrayM") jr_swizzleMethod:@selector(addObject:) withMethod:@selector(guard_addObject:) error:nil];
        [NSClassFromString(@"__NSArrayM") jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(guard_insertObject:atIndex:) error:nil];
        [NSClassFromString(@"__NSArrayM") jr_swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(guard_removeObjectAtIndex:) error:nil];
        [NSClassFromString(@"__NSArrayM") jr_swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(guard_replaceObjectAtIndex:withObject:) error:nil];
    });
}

- (void)guard_addObject:(id)anObject {
    if (!anObject) {
        // 收集堆栈，上报 Crash
        return;
    }
    [self guard_addObject:anObject];
}

- (void)guard_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count || !anObject) {
        // 收集堆栈，上报 Crash
        return;
    }
    [self guard_insertObject:anObject atIndex:index];
}

- (void)guard_removeObjectAtIndex:(NSUInteger)index {
    if (index > self.count) {
        // 收集堆栈，上报 Crash
        return;
    }
    
    return [self guard_removeObjectAtIndex:index];
}

- (void)guard_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index > self.count || !anObject) {
        // 收集堆栈，上报 Crash
        return;
    }
    [self guard_replaceObjectAtIndex:index withObject:anObject];
}

@end
