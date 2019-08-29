//
//  LBApplicationDelegate.m
//  GHLShareLifecycle
//
//  Created by 与佳期 on 2019/8/29.
//

#import "LBApplicationDelegate.h"
#import <objc/runtime.h>
#import "LBLifecycle.h"

static NSString * const kLBLifecycleClass = @"lb_lifecycle_class";

@interface LBApplicationDelegate ()

@property (nonatomic, strong) id <UIApplicationDelegate> realDelegate;

@property (nonatomic, copy) NSArray *subCalsses;

@end

@implementation LBApplicationDelegate

+ (instancetype)sharedInstance {
    static LBApplicationDelegate *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [LBApplicationDelegate new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
#if DEBUG
        NSArray *stringArray = [self _findAllSubClass:[LBLifecycle class]];
        self.subCalsses = [self _classArrayWithStringArray:stringArray];
        [[NSUserDefaults standardUserDefaults] setObject:stringArray forKey:kLBLifecycleClass];
#else
        NSArray *stringArray = [[NSUserDefaults standardUserDefaults] objectForKey:kLBLifecycleClass];
        self.subCalsses = [self _classArrayWithStringArray:stringArray];
#endif
    }
    return self;
}

- (NSArray *)_classArrayWithStringArray:(NSArray *)stringArray {
    NSMutableArray *classArray = [NSMutableArray new];
    [stringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class cls = NSClassFromString(obj);
        if (cls) [classArray addObject:[cls new]];
    }];
    return [classArray copy];
}

- (NSArray *)_findAllSubClass:(Class)class {
    // 注册类的总数
    int count = objc_getClassList(NULL, 0);
    NSMutableArray *array = [NSMutableArray new];
    // 获取所有已注册的类
    Class *classes = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    
    for (int i = 0; i < count; i++) {
        if (class == class_getSuperclass(classes[i])) {
            [array addObject:[NSString stringWithFormat:@"%@", classes[i]]];
        }
    }
    free(classes);
    return array;
}


#pragma mark - 消息转发
- (BOOL)_containsProtocolMethod:(SEL)selector {
    
    unsigned int outCount = 0;
    struct objc_method_description *methodDesc = protocol_copyMethodDescriptionList(@protocol(UIApplicationDelegate), NO, YES, &outCount);
    for (int idx = 0; idx < outCount; idx++) {
        if (selector == methodDesc[idx].name) {
            free(methodDesc);
            return YES;
        }
    }
    free(methodDesc);
    return NO;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.realDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    
    for (LBLifecycle *module in self.subCalsses) {
        if ([self _containsProtocolMethod:aSelector] && [module respondsToSelector:aSelector]) {
            return YES;
        }
    }
    
    return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (![self _containsProtocolMethod:aSelector] && [self.realDelegate respondsToSelector:aSelector]) {
        return self.realDelegate;
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    struct objc_method_description methodDesc = protocol_getMethodDescription(@protocol(UIApplicationDelegate), aSelector, NO, YES);
    
    if (methodDesc.name == NULL && methodDesc.types == NULL) {
        return [[self class] instanceMethodSignatureForSelector:@selector(doNothing)];
    }
    
    return [NSMethodSignature signatureWithObjCTypes:methodDesc.types];;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSMutableArray *allModules = [NSMutableArray arrayWithObjects:self.realDelegate, nil];
    [allModules addObjectsFromArray:self.subCalsses];
    
    // BOOL 型返回值特殊处理
    if (anInvocation.methodSignature.methodReturnType[0] == 'B') {
        BOOL realReturnValue = NO;
        
        for (LBLifecycle *module in allModules) {
            if ([module respondsToSelector:anInvocation.selector]) {
                [anInvocation invokeWithTarget:module];
                
                BOOL returnValue = NO;
                [anInvocation getReturnValue:&returnValue];
                
                realReturnValue = returnValue || realReturnValue;
            }
        }
        
        [anInvocation setReturnValue:&realReturnValue];
    } else {
        for (LBLifecycle *module in allModules) {
            if ([module respondsToSelector:anInvocation.selector]) {
                [anInvocation invokeWithTarget:module];
            }
        }
    }
}

- (void)doNothing {
    
}

@end


@implementation UIApplication (LBLifecycle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(setDelegate:);
        SEL swizzledSelector = @selector(lb_setDelegate:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)lb_setDelegate:(id <UIApplicationDelegate>)delegate {
    [LBApplicationDelegate sharedInstance].realDelegate = delegate;
    [self lb_setDelegate:(id <UIApplicationDelegate>)[LBApplicationDelegate sharedInstance]];
}
@end
