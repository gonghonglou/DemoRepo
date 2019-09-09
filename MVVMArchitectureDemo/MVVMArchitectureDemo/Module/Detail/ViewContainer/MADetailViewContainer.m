//
//  MADetailViewContainer.m
//  MVVMArchitectureDemo
//
//  Created by gonghonglou on 2018/2/12.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MADetailViewContainer.h"
#import "MADetailViewContainerVO.h"

@implementation MADetailViewContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
        [self addSubview:self.titleLabel];
        
        self.num1Label = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 200, 50)];
        [self addSubview:self.num1Label];
        
        self.num2Label = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
        [self addSubview:self.num2Label];
        
        self.num3Label = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 200, 50)];
        [self addSubview:self.num3Label];
    }
    return self;
}

- (void)setDetailViewContainerWithVO:(MADetailViewContainerVO *)viewContainerVO {
    self.titleLabel.text = viewContainerVO.title;
    self.num1Label.text = viewContainerVO.num1;
    self.num2Label.text = viewContainerVO.num2;
    self.num3Label.text = viewContainerVO.num3;
}

@end
