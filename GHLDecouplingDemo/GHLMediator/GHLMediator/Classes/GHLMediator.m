//
//  GHLMediator.m
//  GHLHome
//
//  Created by 与佳期 on 2019/6/11.
//

#import "GHLMediator.h"

@implementation GHLMediator

+ (instancetype)sharedInstance {
    
    static GHLMediator *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [GHLMediator new];
    });
    return sharedInstance;
}

- (nullable id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params {
    
    NSString *targetClassString = [NSString stringWithFormat:@"target_%@", targetName];
    NSString *actionString = [NSString stringWithFormat:@"action_%@:", actionName];
    
    Class targetClass = NSClassFromString(targetClassString);
    id target = [targetClass new];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) return nil;
    
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }
    return nil;
}

@end
