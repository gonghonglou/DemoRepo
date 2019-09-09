//
//  UIViewController+MAAppear.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/13.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "UIViewController+MAAppear.h"
#import <objc/runtime.h>
#import "MACoordinatingController.h"

@implementation UIViewController (MAAppear)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(ma_viewWillAppear:);

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

#pragma mark - Method Swizzling
- (void)ma_viewWillAppear:(BOOL)animated {
    [self ma_viewWillAppear:animated];
    
    if (![self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
        [MACoordinatingController sharedInstance].activeViewController = self;
    }
}

@end
