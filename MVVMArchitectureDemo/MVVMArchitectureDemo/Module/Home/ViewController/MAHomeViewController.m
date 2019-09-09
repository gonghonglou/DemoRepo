//
//  MAHomeViewController.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MAHomeViewController.h"
#import "MAHomeViewContainer.h"
#import "MAHomeViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "MAHomeTableViewCell.h"

@interface MAHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MAHomeViewContainer *viewContainer;

@property (nonatomic, strong) MAHomeViewModel *viewModel;

@end

@implementation MAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel = [MAHomeViewModel new];
    [self layoutUI];
    [self setObserve];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewModel operateDataArray];
}

/**
 页面布局
 */
- (void)layoutUI {
    self.navigationItem.title = @"主页";
    self.viewContainer = [[MAHomeViewContainer alloc] initWithFrame:self.view.frame];
    self.view = self.viewContainer;
    
    self.viewContainer.tableView.dataSource = self;
    self.viewContainer.tableView.delegate = self;
}


/**
 设置数据监听
 */
- (void)setObserve {
    @weakify(self);
    [RACObserve(self.viewModel, dataArray) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.viewContainer.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MAHomeTableViewCell cellIdentifier]];
    if (!cell) {
        cell = [[MAHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MAHomeTableViewCell cellIdentifier]];
    }
    [cell setHomeTableViewCellWithVO:self.viewModel.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel didSelectedCellWithIndexPath:indexPath];
}

@end
