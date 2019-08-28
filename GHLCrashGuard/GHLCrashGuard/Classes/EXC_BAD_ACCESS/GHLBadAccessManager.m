//
//  GHLBadAccessManager.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/9.
//

#import "GHLBadAccessManager.h"
#import <objc/runtime.h>
#import "GHLZoombie.h"

NSString *GHLZoombieClassPrefix = @"_GHLZoombie_";

@implementation GHLBadAccessManager

+ (instancetype)sharedInstance {
    static GHLBadAccessManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)handleDeallocObject:(__unsafe_unretained id)object {
    
    // 指向固定的类，原有类名存储在关联对象中
    NSString *originClassName = NSStringFromClass([object class]);
    objc_setAssociatedObject(object, "originClassName", originClassName, OBJC_ASSOCIATION_COPY_NONATOMIC);

    object_setClass(object, [GHLZoombie class]);
}

//- (void)handleDeallocObject:(__unsafe_unretained id)object {
//
//    // 指向动态生成的类，用 _GHLZoombie_ 拼接原有类名
//    NSString *className = NSStringFromClass([object class]);
//    NSString *zombieClassName = [GHLZoombieClassPrefix stringByAppendingString: className];
//    Class zombieClass = NSClassFromString(zombieClassName);
//    if(zombieClass) return;
//
//    zombieClass = objc_allocateClassPair([NSObject class], [zombieClassName UTF8String], 0);
//    objc_registerClassPair(zombieClass);
//    class_addMethod([zombieClass class], @selector(forwardingTargetForSelector:), (IMP)forwardingTargetForSelector, "@@:@");
//
//    object_setClass(object, zombieClass);
//}
//
//id forwardingTargetForSelector(id object, SEL _cmd, SEL aSelector) {
//
//    NSString *className = NSStringFromClass([object class]);
//    NSString *realClass = [className stringByReplacingOccurrencesOfString:GHLZoombieClassPrefix withString:@""];
//
//    NSLog(@"[%@ %@] message sent to deallocated instance %@", realClass, NSStringFromSelector(aSelector), object);
//    abort();
//}

@end
