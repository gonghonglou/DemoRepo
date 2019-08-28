//
//  UIResponder+GHLEvent.h
//  GHLDecouplingDemo
//
//  Created by 与佳期 on 2019/6/13.
//  Copyright © 2019 与佳期. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (GHLEvent)

- (void)ghl_event:(NSString *)event params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
