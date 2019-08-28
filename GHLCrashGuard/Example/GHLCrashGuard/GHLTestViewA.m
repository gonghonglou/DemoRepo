//
//  GHLTestViewA.m
//  GHLCrashGuard_Example
//
//  Created by 与佳期 on 2019/7/18.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "GHLTestViewA.h"

@implementation GHLTestViewA

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-------GHLTestViewA");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"执行了GHLTestViewA的hitTest");
    return [super hitTest:point withEvent:event];
}


@end
