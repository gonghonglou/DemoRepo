//
//  GHLUnrecognizedSelectorManager.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/9.
//

#import "GHLUnrecognizedSelectorManager.h"
#import <objc/runtime.h>
#import "GHLCrashGuardProxy.h"

@implementation GHLUnrecognizedSelectorManager

+ (instancetype)sharedInstance {
    static GHLUnrecognizedSelectorManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)handleObject:(__unsafe_unretained id)object forwardingTargetForSelector:(SEL)aSelector {
    
    if (![self needGuard:[object class]]) {
        return nil;
    }
    
    NSLog(@"[%@ %@]: unrecognized selector sent to instance %@", [object class], NSStringFromSelector(aSelector), object);
    
    return [GHLCrashGuardProxy new];
}

- (BOOL)needGuard:(Class)cls {
    
    // 如果重写了 forwardInvocation，说明自己要处理，这里直接返回
    if ([self methodHasOverwrited:@selector(forwardInvocation:) cls:cls]) {
        return NO;
    }
    return YES;
}

// 判断 cls 是否重写了 sel 方法，递归调用判断但不包括 NSObject
- (BOOL)methodHasOverwrited:(SEL)sel cls:(Class)cls {
    
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(cls, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        if (method_getName(method) == sel) {
            free(methods);
            return YES;
        }
    }
    free(methods);
    
    // 可能父类实现了这个 sel，一直遍历到基类 NSObject 为止
    if ([cls superclass] != [NSObject class]) {
        return [self methodHasOverwrited:sel cls:[cls superclass]];
    }
    return NO;
}

@end
