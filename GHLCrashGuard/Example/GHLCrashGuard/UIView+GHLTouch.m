//
//  UIView+GHLTouch.m
//  GHLCrashGuard_Example
//
//  Created by 与佳期 on 2019/7/18.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "UIView+GHLTouch.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation UIView (GHLTouch)

+ (void)load {
    [self jr_swizzleMethod:@selector(hitTest:withEvent:) withMethod:@selector(ghl_hitTest:withEvent:) error:nil];
    [self jr_swizzleMethod:@selector(pointInside:withEvent:) withMethod:@selector(ghl_pointInside:withEvent:) error:nil];
}

- (UIView *)ghl_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitTest = [self ghl_hitTest:point withEvent:event];
    NSLog(@"hitTest:----%@", self.class);
    return hitTest;
}

- (BOOL)ghl_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL pointInside = [self ghl_pointInside:point withEvent:event];
    NSLog(@"pointInside:---%d----%@", pointInside, self.class);
    return pointInside;
}

@end
