//
//  GHLShareLifecycle.h
//  GHLShareLifecycle
//
//  Created by 与佳期 on 2019/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLShareLifecycle : NSObject

- (NSArray *)findSubClass:(Class)defaultClass;

+ (void)execClassSelector:(SEL)selector forClass:(Class)class withParam1:(id)param1 param2:(id _Nullable)param2;

// lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)applicationWillResignActive:(UIApplication *)application;

- (void)applicationDidEnterBackground:(UIApplication *)application;

- (void)applicationWillEnterForeground:(UIApplication *)application;

- (void)applicationDidBecomeActive:(UIApplication *)application;

- (void)applicationWillTerminate:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
