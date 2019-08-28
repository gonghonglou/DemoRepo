//
//  NSNumber+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/11.
//

#import "NSNumber+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSNumber (GHLCrashGuard)

+ (void)load {
    
    [NSClassFromString(@"__NSCFNumber") jr_swizzleMethod:@selector(isEqualToNumber:) withMethod:@selector(guard_isEqualToNumber:) error:nil];
    [NSClassFromString(@"__NSCFNumber") jr_swizzleMethod:@selector(compare:) withMethod:@selector(guard_compare:) error:nil];
}

- (BOOL)guard_isEqualToNumber:(NSNumber *)number {
    if (!number) {
        return NO;
    }
    return [self guard_isEqualToNumber:number];
}

- (NSComparisonResult)guard_compare:(NSNumber *)number {
    if (!number) {
        return NSOrderedAscending;
    }
    return [self guard_compare:number];
}

@end
