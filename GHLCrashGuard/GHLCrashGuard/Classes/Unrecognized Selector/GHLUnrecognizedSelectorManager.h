//
//  GHLUnrecognizedSelectorManager.h
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLUnrecognizedSelectorManager : NSObject

+ (instancetype)sharedInstance;

- (id)handleObject:(__unsafe_unretained id)object forwardingTargetForSelector:(SEL)aSelector;


@end

NS_ASSUME_NONNULL_END
