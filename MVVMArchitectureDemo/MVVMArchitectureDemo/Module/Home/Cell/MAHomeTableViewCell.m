//
//  MAHomeTableViewCell.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MAHomeTableViewCell.h"
#import "MAHomeTableViewCellVO.h"

@implementation MAHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 200, 40)];
        [self.contentView addSubview:self.titleLabel];
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 200, 40)];
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}


- (void)setHomeTableViewCellWithVO:(MAHomeTableViewCellVO *)cellVO {
    self.titleLabel.text = cellVO.title;
    self.messageLabel.text = cellVO.message;
}


+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
