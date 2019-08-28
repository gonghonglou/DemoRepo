//
//  GHLTestView.m
//  GHLCrashGuard_Example
//
//  Created by 与佳期 on 2019/7/17.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "GHLTestView.h"

@implementation GHLTestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"--init--");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"--initWithFrame--");
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    NSLog(@"---");
}

- (void)layoutSubviews {
    NSLog(@"---");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-------GHLTestView");
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return YES;
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return self.viewA;
}


@end
