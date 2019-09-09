//
//  TestViewController.m
//  ScrollViewDemo
//
//  Created by gonghonglou on 2018/2/11.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "TestViewController.h"
#import "MyScrollView.h"

@interface TestViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MyScrollView *scrollView;

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

// 页面布局
- (void)layoutUI {
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    
    // scroll view
    self.scrollView = [[MyScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 2, 0);
    [self.view addSubview:self.scrollView];
    
    // left table view
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-160) style:UITableViewStylePlain];
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.leftTableView];
    
    // right table view
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(viewWidth, 0, viewWidth, viewHeight-160) style:UITableViewStylePlain];
    [self.scrollView addSubview:self.rightTableView];
    
    self.scrollView.delegate = self;
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 60;
    self.leftTableView.tableFooterView = [UIView new];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.rowHeight = 80;
    self.rightTableView.tableFooterView = [UIView new];
    
    // label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, viewHeight-60, viewWidth, 20)];
    label.text = @"滑动此区域可切换页面";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    // pagControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, viewHeight - 50, viewWidth, 50)];
    self.pageControl.numberOfPages = 2;
    self.pageControl.enabled = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:self.pageControl];
}

// UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        NSInteger pageIndex = (NSInteger)(scrollView.contentOffset.x / (scrollView.frame.size.width / 2));
        self.pageControl.currentPage = pageIndex;
    }
}

// UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 5;
    } else {
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"table_view_cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"table_view_cell"];
    }
    if (tableView == self.leftTableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"left-table-view-cell--%ld", (long)indexPath.row];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"right-table-view-cell--%ld", (long)indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// UITableViewDelegate 左划按钮的回调方法
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:NSLocalizedString(@"删除", nil) handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"---执行删除操作---%ld", (long)indexPath.row);
    }];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.scrollView.scrollEnabled = NO;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath {
    self.scrollView.scrollEnabled = YES;
}

@end

