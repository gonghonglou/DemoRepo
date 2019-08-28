//
//  GHLRouter.h
//  GHLHome
//
//  Created by 与佳期 on 2019/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLRouter : NSObject

+ (instancetype)sharedInstance;

- (id)routerWithUrlString:(NSString *)urlString;

- (id)routerWithUrlString:(NSString *)urlString params:(NSDictionary *)params;

- (id)openURLString:(NSString *)urlString;

- (nullable id)openURLString:(NSString *)urlString params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END


@interface UIViewController (GHLRouter)

@property (nonatomic, strong, readonly) NSDictionary * _Nullable params;

@end
