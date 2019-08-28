//
//  GHLShareLifecycle+a4ifecycle.m
//  a4ifecycle
//
//  Created by 与佳期 on 2019/8/25.
//

#import "GHLShareLifecycle+a4ifecycle.h"

@implementation GHLShareLifecycle (a4ifecycle)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"---a4ifecycle---didFinishLaunchingWithOptions");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"---a4ifecycle---applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"---a4ifecycle---applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"---a4ifecycle---applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"---a4ifecycle---applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"---a4ifecycle---applicationWillTerminate");
}

@end
