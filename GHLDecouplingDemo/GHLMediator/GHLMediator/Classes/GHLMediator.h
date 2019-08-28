//
//  GHLMediator.h
//  GHLHome
//
//  Created by 与佳期 on 2019/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLMediator : NSObject

+ (instancetype)sharedInstance;

- (nullable id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
