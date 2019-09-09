//
//  MALoginViewContainer.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MALoginViewContainer.h"

@implementation MALoginViewContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.confirmButton.frame = CGRectMake(100, 300, 175, 40);
        self.confirmButton.layer.cornerRadius = 4.0;
        self.confirmButton.backgroundColor = [UIColor redColor];
        [self.confirmButton setTitle:@"点击登录" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.confirmButton];
    }
    return self;
}

@end
