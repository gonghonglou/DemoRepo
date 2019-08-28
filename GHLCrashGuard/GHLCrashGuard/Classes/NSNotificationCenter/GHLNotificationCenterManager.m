//
//  GHLNotificationCenterManager.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/14.
//

#import "GHLNotificationCenterManager.h"
#import <objc/runtime.h>

@implementation GHLNotificationCenterManager

+ (instancetype)sharedInstance {
    static GHLNotificationCenterManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)handleObjectRemoveObserver:(__unsafe_unretained id)object {
    NSString *addObserver = objc_getAssociatedObject(object, "addObserverFlag");
    if ([addObserver boolValue]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

@end
