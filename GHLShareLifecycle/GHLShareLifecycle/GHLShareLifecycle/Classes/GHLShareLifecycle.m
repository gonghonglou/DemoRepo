//
//  GHLShareLifecycle.m
//  GHLShareLifecycle
//
//  Created by 与佳期 on 2019/8/24.
//

#import "GHLShareLifecycle.h"
#import <objc/runtime.h>

@implementation GHLShareLifecycle

// Notification Once
+ (void)load {
    __block id observer =
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIApplicationDidFinishLaunchingNotification
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) {
         NSLog(@"------------------------------");
         [[NSNotificationCenter defaultCenter] removeObserver:observer];
     }];
}

// 获取所有子类
+ (NSArray *)findSubClass:(Class)class {
    // 注册类的总数
    int count = objc_getClassList(NULL, 0);
    NSMutableArray *array = [NSMutableArray new];
    // 获取所有已注册的类
    Class *classes = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    
    for (int i = 0; i < count; i++) {
        if (class == class_getSuperclass(classes[i])) {
            [array addObject:classes[i]];
        }
    }
    free(classes);
    return array;
}


#pragma mark - 寻找方法列表，调用本类/分类方法
+ (void)execClassSelector:(SEL)selector forClass:(Class)class withParam1:(id)param1 param2:(id)param2 {
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(class, &methodCount);
    for (int i = methodCount - 1; i >= 0; i--) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        if ([NSStringFromSelector(sel) isEqualToString:NSStringFromSelector(selector)]) {
            IMP imp = method_getImplementation(method);
            void (*func)(id, SEL,id,id) = (void *)imp;
            func(self, sel, param1, param2);
            break;
        }
    }
    free(methods);
}

+ (void)execCategorySelector:(SEL)selector forClass:(Class)class withParam1:(id)param1 param2:(id)param2 {
    BOOL isFirst = NO;
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(class, &methodCount);
    for (int i = methodCount - 1; i >= 0; i--) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        if ([NSStringFromSelector(sel) isEqualToString:NSStringFromSelector(selector)]) {
            if (!isFirst) {
                isFirst = YES;
            } else {
                IMP imp = method_getImplementation(method);
                void (*func)(id, SEL,id,id) = (void *)imp;
                func(self, sel, param1, param2);
            }
        }
    }
    free(methods);
    
    
//    NSString *selectorString = NSStringFromSelector(selector);
//    NSString *classString = NSStringFromClass(class);
//    NSMutableArray *selectorArray = [self.classSelelctorMap[classString][selectorString] mutableCopy];
//    if (!selectorArray) selectorArray = [NSMutableArray new];
//
//    if (selectorArray.count <= 0) {
//        unsigned int methodCount = 0;
//        Method *methods = class_copyMethodList(class, &methodCount);
//        for (int i = 0; i < methodCount; i++) {
//            Method method = methods[i];
//            SEL sel = method_getName(method);
//            if ([NSStringFromSelector(sel) isEqualToString:selectorString]) {
//                [selectorArray addObject:(__bridge id)(method)];
//            }
//        }
//        free(methods);
//
////    @{
////      @"class1" : @{@"selector1" : @[],
////                   @"selector2" : @[]
////                   },
////      @"class2" : @{@"selector1" : @[],
////                   @"selector2" : @[]
////                   }
////      }
//        NSDictionary *selectorDict = @{selectorString : [selectorArray copy]};
//
//        NSMutableDictionary *classDict = [self.classSelelctorMap[classString] mutableCopy];
//        if (!classDict) classDict = [NSMutableDictionary new];
//        classDict[classString] = selectorDict;
//
//        self.classSelelctorMap = classDict;
//    }
//
//    for (NSInteger i = 0; i < selectorArray.count; i++) {
//        if (i == 0) continue;
//        Method method = (__bridge Method)(selectorArray[i]);
//        SEL sel = method_getName(method);
//        IMP imp = method_getImplementation(method);
//        void (*func)(id, SEL,id,id) = (void *)imp;
//        func(self, sel, param1, param2);
//    }
}

#pragma mark - lifecycle 生命周期方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GHLShareLifecycle execCategorySelector:_cmd forClass:[self class] withParam1:application param2:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [GHLShareLifecycle execCategorySelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [GHLShareLifecycle execCategorySelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [GHLShareLifecycle execCategorySelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [GHLShareLifecycle execCategorySelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [GHLShareLifecycle execCategorySelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

@end
