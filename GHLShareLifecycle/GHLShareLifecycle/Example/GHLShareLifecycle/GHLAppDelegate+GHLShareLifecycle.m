//
//  GHLAppDelegate+GHLShareLifecycle.m
//  GHLShareLifecycle_Example
//
//  Created by 与佳期 on 2019/8/26.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "GHLAppDelegate+GHLShareLifecycle.h"
#import <objc/runtime.h>
#import <GHLShareLifecycle/GHLShareLifecycle.h>

@implementation GHLAppDelegate (GHLShareLifecycle)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GHLShareLifecycle execClassSelector:_cmd forClass:[GHLShareLifecycle class] withParam1:application param2:launchOptions];
    [GHLShareLifecycle execClassSelector:_cmd forClass:[self class] withParam1:application param2:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [GHLShareLifecycle execClassSelector:_cmd forClass:[GHLShareLifecycle class] withParam1:application param2:nil];
    [GHLShareLifecycle execClassSelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [GHLShareLifecycle execClassSelector:_cmd forClass:[GHLShareLifecycle class] withParam1:application param2:nil];
    [GHLShareLifecycle execClassSelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [GHLShareLifecycle execClassSelector:_cmd forClass:[GHLShareLifecycle class] withParam1:application param2:nil];
    [GHLShareLifecycle execClassSelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [GHLShareLifecycle execClassSelector:_cmd forClass:[GHLShareLifecycle class] withParam1:application param2:nil];
    [GHLShareLifecycle execClassSelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [GHLShareLifecycle execClassSelector:_cmd forClass:[GHLShareLifecycle class] withParam1:application param2:nil];
    [GHLShareLifecycle execClassSelector:_cmd forClass:[self class] withParam1:application param2:nil];
}

@end
