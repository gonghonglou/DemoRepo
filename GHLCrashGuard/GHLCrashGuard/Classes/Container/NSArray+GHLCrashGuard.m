//
//  NSArray+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/11.
//

#import "NSArray+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSArray (GHLCrashGuard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        // [NSArray alloc]
//        [NSClassFromString(@"__NSPlaceholderArray") jr_swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(initWithObjects_guard:count:) error:nil];
//        // NSArray
//        [NSClassFromString(@"NSArray") jr_swizzleMethod:@selector(arrayWithObjects:count:) withMethod:@selector(arrayWithObjects_guard:count:) error:nil];
        // @[]
        [NSClassFromString(@"__NSArray0") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(guard_objectAtIndex:) error:nil];
        [NSClassFromString(@"__NSArray0") jr_swizzleMethod:@selector(arrayByAddingObject:) withMethod:@selector(guard_arrayByAddingObject:) error:nil];
        // @[@1]
        [NSClassFromString(@"__NSSingleObjectArrayI") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(guard_objectAtIndex:) error:nil];
        [NSClassFromString(@"__NSSingleObjectArrayI") jr_swizzleMethod:@selector(arrayByAddingObject:) withMethod:@selector(guard_arrayByAddingObject:) error:nil];
        // @[@1, @2]
        [NSClassFromString(@"__NSArrayI") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(guard_objectAtIndex:) error:nil];
        [NSClassFromString(@"__NSArrayI") jr_swizzleMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(guard_objectAtIndexedSubscript:) error:nil];
        [NSClassFromString(@"__NSArrayI") jr_swizzleMethod:@selector(arrayByAddingObject:) withMethod:@selector(guard_arrayByAddingObject:) error:nil];
    });
}

- (id)guard_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        // 收集堆栈，上报 Crash
        return nil;
    }
    return [self guard_objectAtIndex:index];
}

- (id)guard_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        // 收集堆栈，上报 Crash
        return nil;
    }
    return [self guard_objectAtIndexedSubscript:index];
}

- (NSArray *)guard_arrayByAddingObject:(id)anObject {
    if (!anObject) {
        // 收集堆栈，上报 Crash
        return self;
    }
    return [self guard_arrayByAddingObject:anObject];
}


- (instancetype)initWithObjects_guard:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            break;
        }
        newCnt++;
    }
    return [self initWithObjects_guard:objects count:newCnt];
}

+ (instancetype)arrayWithObjects_guard:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            break;
        }
        newCnt++;
    }
    return [self arrayWithObjects_guard:objects count:newCnt];
}

@end
