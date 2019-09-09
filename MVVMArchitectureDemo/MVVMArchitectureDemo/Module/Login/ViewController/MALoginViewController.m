//
//  MALoginViewController.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MALoginViewController.h"
#import "MALoginViewContainer.h"
#import "MALoginViewModel.h"

@interface MALoginViewController ()

@property (nonatomic, strong) MALoginViewContainer *viewContainer;

@property (nonatomic, strong) MALoginViewModel *viewModel;

@end

@implementation MALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel = [MALoginViewModel new];
    [self layoutUI];
}


/**
 页面布局
 */
- (void)layoutUI {
    self.navigationItem.title = @"登录页";
    self.viewContainer = [MALoginViewContainer new];
    self.view = self.viewContainer;
    
    [self.viewContainer.confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
}


/**
 点击登录按钮
 */
- (void)clickConfirmButton {
    [self.viewModel login];
}

@end
