//
//  GHLTestView.h
//  GHLCrashGuard_Example
//
//  Created by 与佳期 on 2019/7/17.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLTestView : UIView

@property (nonatomic, weak) void (^testBlock)(void);

@property (nonatomic, strong) UIView *viewA;

@end

NS_ASSUME_NONNULL_END
