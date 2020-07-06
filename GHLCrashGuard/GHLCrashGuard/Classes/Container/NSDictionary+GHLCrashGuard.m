//
//  NSDictionary+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/11.
//

#import "NSDictionary+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSDictionary (GHLCrashGuard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [NSClassFromString(@"NSDictionary") jr_swizzleMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(guard_dictionaryWithObjects:forKeys:count:) error:nil];
    });
}

- (instancetype)initWithObjects_guard:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }
        newCnt++;
    }
    self = [self initWithObjects_guard:objects forKeys:keys count:newCnt];
    return self;
}

@end
