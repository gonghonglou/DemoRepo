//
//  GHLShareLifecycle+A4Share.m
//  A4ShareLifecycle
//
//  Created by 与佳期 on 2019/8/25.
//

#import "GHLShareLifecycle+A4Share.h"

@implementation GHLShareLifecycle (A4Share)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"---A4Share---didFinishLaunchingWithOptions");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"---A4Share---applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"---A4Share---applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"---A4Share---applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"---A4Share---applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"---A4Share---applicationWillTerminate");
}

@end
