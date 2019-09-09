//
//  MALoginViewModel.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MALoginViewModel.h"
#import "MACoordinatingController.h"

@implementation MALoginViewModel


/**
 登录方法
 */
- (void)login {    
    [[MACoordinatingController sharedInstance] pushToHomeViewController];
}

@end
