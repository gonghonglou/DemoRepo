//
//  MAHomeViewContainer.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MAHomeViewContainer.h"

@implementation MAHomeViewContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.tableView.rowHeight = 100;
        self.tableView.tableFooterView = [UIView new];
        [self addSubview:self.tableView];
    }
    return self;
}

@end
