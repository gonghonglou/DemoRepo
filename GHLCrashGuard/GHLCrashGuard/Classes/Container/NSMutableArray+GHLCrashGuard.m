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
    
    [NSClassFromString(@"__NSArrayM") jr_swizzleMethod:@selector(addObject:) withMethod:@selector(guard_addObject:) error:nil];
    [NSClassFromString(@"__NSArrayM") jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(guard_insertObject:atIndex:) error:nil];
    [NSClassFromString(@"__NSArrayM") jr_swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(guard_removeObjectAtIndex:) error:nil];
    [NSClassFromString(@"__NSArrayM") jr_swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(guard_replaceObjectAtIndex:withObject:) error:nil];
}


- (void)guard_addObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self guard_addObject:anObject];
}

- (void)guard_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self guard_insertObject:anObject atIndex:index];
}

- (void)guard_removeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return;
    }
    
    return [self guard_removeObjectAtIndex:index];
}
- (void)guard_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self guard_replaceObjectAtIndex:index withObject:anObject];
}

@end
