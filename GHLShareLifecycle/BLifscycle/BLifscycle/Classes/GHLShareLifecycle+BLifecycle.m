//
//  GHLShareLifecycle+BLifecycle.m
//  BLifscycleDemo
//
//  Created by 与佳期 on 2019/8/25.
//

#import "GHLShareLifecycle+BLifecycle.h"

@implementation GHLShareLifecycle (BLifecycle)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"---BLifecycle---didFinishLaunchingWithOptions");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"---BLifecycle---applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"---BLifecycle---applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"---BLifecycle---applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"---BLifecycle---applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"---BLifecycle---applicationWillTerminate");
}

@end
