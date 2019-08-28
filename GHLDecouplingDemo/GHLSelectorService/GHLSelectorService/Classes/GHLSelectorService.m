//
//  GHLSelectorService.m
//  GHLSelectorService
//
//  Created by 与佳期 on 2019/6/13.
//

#import "GHLSelectorService.h"
#import <objc/message.h>

@implementation GHLSelectorService

+ (nullable id)call:(NSString *)serviceString withParams:(NSDictionary *)params {
    NSArray *serviceArray = [serviceString componentsSeparatedByString:@"/"];
    NSString *targetClassString = [NSString stringWithFormat:@"selector_%@", serviceArray.firstObject];
    NSString *actionString = [NSString stringWithFormat:@"%@:", serviceArray.lastObject];
    
    Class targetClass = NSClassFromString(targetClassString);
    id target = [targetClass new];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) return nil;
    
    if ([target respondsToSelector:action]) {
//        return [target performSelector:action withObject:params];
        return ((id (*)(id, SEL, id))objc_msgSend)(target, action, params);
    }
    return nil;
}

@end
