//
//  GHLLifecycleB.m
//  GHLShareLifecycle_Example
//
//  Created by 与佳期 on 2019/8/30.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "GHLLifecycleB.h"

@implementation GHLLifecycleB

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"---GHLLifecycleB---didFinishLaunchingWithOptions");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"---GHLLifecycleB---applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"---GHLLifecycleB---applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"---GHLLifecycleB---applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"---GHLLifecycleB---applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"---GHLLifecycleB---applicationWillTerminate");
}

@end
