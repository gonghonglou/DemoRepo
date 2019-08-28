//
//  GHLShareLifecycle+ALifecycle.m
//  ALifscycleDemo
//
//  Created by 与佳期 on 2019/8/25.
//

#import "GHLShareLifecycle+ALifecycle.h"

@implementation GHLShareLifecycle (ALifecycle)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"---ALifecycle---didFinishLaunchingWithOptions");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"---ALifecycle---applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"---ALifecycle---applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"---ALifecycle---applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"---ALifecycle---applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"---ALifecycle---applicationWillTerminate");
}

@end
