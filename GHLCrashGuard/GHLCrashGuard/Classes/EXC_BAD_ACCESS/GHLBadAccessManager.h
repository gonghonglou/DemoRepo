//
//  GHLBadAccessManager.h
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLBadAccessManager : NSObject

+ (instancetype)sharedInstance;

- (void)handleDeallocObject:(__unsafe_unretained id)object;

@end

NS_ASSUME_NONNULL_END
