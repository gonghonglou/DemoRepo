//
//  GHLZoombie.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/8.
//

#import "GHLZoombie.h"
#import <objc/runtime.h>
#import "GHLCrashGuardProxy.h"

@implementation GHLZoombie

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    NSLog(@"[%@ %@] message sent to deallocated instance %@", objc_getAssociatedObject(self, "originClassName"), NSStringFromSelector(aSelector), self);
    
    return [GHLCrashGuardProxy new];
}

@end
