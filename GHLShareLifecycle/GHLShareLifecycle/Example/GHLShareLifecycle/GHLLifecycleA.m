//
//  GHLLifecycleA.m
//  GHLShareLifecycle_Example
//
//  Created by 与佳期 on 2019/8/30.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "GHLLifecycleA.h"

@implementation GHLLifecycleA

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"---GHLLifecycleA---didFinishLaunchingWithOptions");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"---GHLLifecycleA---applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"---GHLLifecycleA---applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"---GHLLifecycleA---applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"---GHLLifecycleA---applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"---GHLLifecycleA---applicationWillTerminate");
}

@end
