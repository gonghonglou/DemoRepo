//
//  GHLSelectorService.h
//  GHLSelectorService
//
//  Created by 与佳期 on 2019/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLSelectorService : NSObject

+ (nullable id)call:(NSString *)serviceString withParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
