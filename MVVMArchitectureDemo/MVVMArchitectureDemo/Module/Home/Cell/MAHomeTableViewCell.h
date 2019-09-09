//
//  MAHomeTableViewCell.h
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAHomeTableViewCellVO;

@interface MAHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *messageLabel;


- (void)setHomeTableViewCellWithVO:(MAHomeTableViewCellVO *)cellVO;

+ (NSString *)cellIdentifier;

@end
