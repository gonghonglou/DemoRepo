//
//  NSString+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/11.
//

#import "NSString+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSString (GHLCrashGuard)

+ (void)load {
    
    [NSClassFromString(@"__NSCFString") jr_swizzleMethod:@selector(characterAtIndex:) withMethod:@selector(guard_characterAtIndex:) error:nil];
    [NSClassFromString(@"__NSCFString") jr_swizzleMethod:@selector(substringWithRange:) withMethod:@selector(guard_substringWithRange:) error:nil];
}

- (unichar)guard_characterAtIndex:(NSUInteger)index {
    if (index >= [self length]) {
        return 0;
    }
    return [self guard_characterAtIndex:index];
}

- (NSString *)guard_substringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        return @"";
    }
    return [self guard_substringWithRange:range];
}

@end
