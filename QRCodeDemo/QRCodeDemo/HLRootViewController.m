//
//  HLRootViewController.m
//  HLCodeScanDemo
//
//  Created by gonghonglou on 16/7/31.
//  Copyright © 2016年 gonghonglou. All rights reserved.
//

#import "HLRootViewController.h"
#import "HLCodeScanViewController.h"
#import "HLBarCodeViewController.h"
#import "HLQRCodeViewController.h"

@interface HLRootViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) NSArray *viewArray;

@end

@implementation HLRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.dataArray = @[@"扫描二维码", @"生成二维码", @"生成条形码"];
    self.viewArray = @[[HLCodeScanViewController new], [HLQRCodeViewController new], [HLBarCodeViewController new]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HLCodeScanDemo_UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HLCodeScanDemo_UITableViewCell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:self.viewArray[indexPath.row] animated:YES];
}

@end
