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
    
    // [NSArray alloc]
    [NSClassFromString(@"__NSPlaceholderArray") jr_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(initWithObjects_guard:forKeys:count:) error:nil];
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
