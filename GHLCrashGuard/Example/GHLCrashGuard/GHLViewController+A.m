//
//  GHLViewController+A.m
//  GHLCrashGuard_Example
//
//  Created by 与佳期 on 2019/7/16.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "GHLViewController+A.h"

@implementation GHLViewController (A)

+ (void)initialize {
    NSLog(@"initialize------Category");
}

+ (void)load {
    NSLog(@"load------Category");
}

+ (void)testlog3 {
    NSLog(@"3------");
}

+ (void)testlogA {
    NSLog(@"---A---");
}

@end
