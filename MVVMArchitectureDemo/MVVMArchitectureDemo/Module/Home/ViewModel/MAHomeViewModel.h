//
//  MAHomeViewModel.h
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAHomeViewModel : NSObject

@property (nonatomic, copy) NSArray *dataArray;

/**
 逻辑处理，生成数据
 */
- (void)operateDataArray;

/**
 点击 cell
 
 @param indexPath 点击位置
 */
- (void)didSelectedCellWithIndexPath:(NSIndexPath *)indexPath;

@end
