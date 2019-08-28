//
//  NSObject+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/7.
//

#import "NSObject+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>
#import "GHLUnrecognizedSelectorManager.h"
#import "GHLBadAccessManager.h"
#import "GHLNotificationCenterManager.h"

@implementation NSObject (GHLCrashGuard)

//+ (void)load {
//    // Unrecognized Selector
//    [self jr_swizzleMethod:@selector(forwardingTargetForSelector:) withMethod:@selector(ghl_forwardingTargetForSelector:) error:nil];
//    // EXC_BAD_ACCESS
//    [self jr_swizzleMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(ghl_dealloc) error:nil];
//}

- (id)ghl_forwardingTargetForSelector:(SEL)aSelector {
    
    return [[GHLUnrecognizedSelectorManager sharedInstance] handleObject:self forwardingTargetForSelector:aSelector];
}

- (void)ghl_dealloc {
    
    [[GHLBadAccessManager sharedInstance] handleDeallocObject:self];
//    if ([UIDevice currentDevice].systemVersion.doubleValue < 9.0) {
//        [[GHLNotificationCenterManager sharedInstance] handleObjectRemoveObserver:self];
//    }
//    [self ghl_dealloc];
}

@end
