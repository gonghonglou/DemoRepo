//
//  MADetailViewController.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MADetailViewController.h"
#import "MADetailViewContainer.h"
#import "MADetailViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface MADetailViewController ()

@property (nonatomic, strong) MADetailViewContainer *viewContainer;

@property (nonatomic, strong) MADetailViewModel *viewModel;

@end

@implementation MADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self layoutUI];
    [self setObserve];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewModel operateDetailViewContainerVO];
}


- (void)layoutUI {
    self.navigationItem.title = @"详情页";
    self.viewContainer = [[MADetailViewContainer alloc] initWithFrame:self.view.frame];
    self.view = self.viewContainer;
}


- (void)setObserve {
    @weakify(self);
    [RACObserve(self.viewModel, viewContainerVO) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.viewContainer setDetailViewContainerWithVO:x];
    }];
}


- (void)setViewModelTitle:(NSString *)title {
    if (!self.viewModel) self.viewModel = [MADetailViewModel new];
    [self.viewModel setViewModelTitle:title];
}

@end
