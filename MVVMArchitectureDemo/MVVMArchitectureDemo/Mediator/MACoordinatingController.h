//
//  MACoordinatingController.h
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MACoordinatingController : NSObject

// 记录当前viewController
@property (nonatomic, strong) UIViewController *activeViewController;


/**
 单例
 
 @return MACoordinatingController
 */
+ (MACoordinatingController *)sharedInstance;


/**
 推出首页
 */
- (void)pushToHomeViewController;


/**
 推出详情页
 */
- (void)pushToDetailViewControllerWithTitle:(NSString *)title;


@end
