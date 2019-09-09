//
//  MADetailViewModel.h
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MADetailViewContainerVO;

@interface MADetailViewModel : NSObject

@property (nonatomic, strong) MADetailViewContainerVO *viewContainerVO;


- (void)setViewModelTitle:(NSString *)title;

- (void)operateDetailViewContainerVO;

@end
