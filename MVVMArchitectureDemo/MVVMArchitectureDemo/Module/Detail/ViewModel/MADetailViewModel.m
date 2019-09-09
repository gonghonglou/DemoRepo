//
//  MADetailViewModel.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MADetailViewModel.h"
#import "MADetailViewContainerVO.h"

@interface MADetailViewModel ()

@property (nonatomic, copy) NSString *title;

@end

@implementation MADetailViewModel


- (void)setViewModelTitle:(NSString *)title {
    self.title = title;
}


- (void)operateDetailViewContainerVO {
    MADetailViewContainerVO *viewContainerVO = [MADetailViewContainerVO new];
    viewContainerVO.title = self.title;
    viewContainerVO.num1 = @"num1";
    viewContainerVO.num2 = @"num2";
    viewContainerVO.num3 = @"num3";
    
    self.viewContainerVO = viewContainerVO;
}

@end
