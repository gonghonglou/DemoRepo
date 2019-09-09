//
//  MADetailViewContainer.h
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MADetailViewContainerVO;

@interface MADetailViewContainer : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *num1Label;

@property (nonatomic, strong) UILabel *num2Label;

@property (nonatomic, strong) UILabel *num3Label;


- (void)setDetailViewContainerWithVO:(MADetailViewContainerVO *)viewContainerVO;

@end
