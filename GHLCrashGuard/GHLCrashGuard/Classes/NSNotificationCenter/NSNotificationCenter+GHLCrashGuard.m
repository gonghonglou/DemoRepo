//
//  NSNotificationCenter+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/14.
//

#import "NSNotificationCenter+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>
#import <objc/runtime.h>


@implementation NSNotificationCenter (GHLCrashGuard)

+ (void)load {
    if ([UIDevice currentDevice].systemVersion.doubleValue < 9.0) {
        [self jr_swizzleMethod:@selector(addObserver:selector:name:object:) withMethod:@selector(ghl_addObserver:selector:name:object:) error:nil];
    }
}

- (void)ghl_addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject {
    [self ghl_addObserver:observer selector:aSelector name:aName object:anObject];
    
    objc_setAssociatedObject(observer, "addObserverFlag", @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
