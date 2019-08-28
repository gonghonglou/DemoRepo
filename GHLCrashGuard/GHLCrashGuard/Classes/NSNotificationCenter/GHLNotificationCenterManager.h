//
//  GHLNotificationCenterManager.h
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLNotificationCenterManager : NSObject

+ (instancetype)sharedInstance;

- (void)handleObjectRemoveObserver:(__unsafe_unretained id)object;

@end

NS_ASSUME_NONNULL_END
