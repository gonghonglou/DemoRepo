//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by gonghonglou on 2017/12/23.
//  Copyright © 2017年 Troy. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle: @"推出页面" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 4.0;
    button.frame = CGRectMake(100, 300, self.view.frame.size.width-200, 40);
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton {
    [self.navigationController pushViewController:[TestViewController new] animated:YES];    
}

@end
