//
//  MACoordinatingController.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MACoordinatingController.h"
#import "MALoginViewController.h"
#import "MAHomeViewController.h"
#import "MADetailViewController.h"

@interface MACoordinatingController ()

@property (nonatomic, strong) MAHomeViewController *homeVC;

@property (nonatomic, strong) MADetailViewController *detailVC;

@end

@implementation MACoordinatingController

/**
 单例
 
 @return MACoordinatingController
 */
+ (MACoordinatingController *)sharedInstance {
    static MACoordinatingController *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化
 
 @return MACoordinatingController
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        _activeViewController = [MALoginViewController new];
    }
    return self;
}


/**
 推出首页
 */
- (void)pushToHomeViewController {
    if (!self.homeVC) self.homeVC = [MAHomeViewController new];
    [_activeViewController.navigationController pushViewController:self.homeVC animated:YES];
}


/**
 推出详情页
 */
- (void)pushToDetailViewControllerWithTitle:(NSString *)title {
    if (!self.detailVC) self.detailVC = [MADetailViewController new];
    [self.detailVC setViewModelTitle:title];
    [_activeViewController.navigationController pushViewController:self.detailVC animated:YES];
}

@end
