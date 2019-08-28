//
//  NSMutableString+GHLCrashGuard.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/11.
//

#import "NSMutableString+GHLCrashGuard.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSMutableString (GHLCrashGuard)

+ (void)load {
    
    [NSClassFromString(@"__NSCFConstantString") jr_swizzleMethod:@selector(appendString:) withMethod:@selector(guard_appendString:) error:nil];
    [NSClassFromString(@"__NSCFConstantString") jr_swizzleMethod:@selector(appendFormat:) withMethod:@selector(guard_appendFormat:) error:nil];
    [NSClassFromString(@"__NSCFConstantString") jr_swizzleMethod:@selector(setString:) withMethod:@selector(guard_setString:) error:nil];
    [NSClassFromString(@"__NSCFConstantString") jr_swizzleMethod:@selector(insertString:atIndex:) withMethod:@selector(guard_insertString:atIndex:) error:nil];
}

- (void)guard_appendString:(NSString *)aString {
    if (!aString) {
        return;
    }
    [self guard_appendString:aString];
}

- (void)guard_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
    if (!format) {
        return;
    }
    va_list arguments;
    va_start(arguments, format);
    NSString *formatStr = [[NSString alloc]initWithFormat:format arguments:arguments];
    [self guard_appendFormat:@"%@",formatStr];
    va_end(arguments);
}

- (void)guard_setString:(NSString *)aString {
    if (!aString) {
        return;
    }
    [self guard_setString:aString];
}

- (void)guard_insertString:(NSString *)aString atIndex:(NSUInteger)index {
    if (index > [self length]) {
        return;
    }
    if (!aString) {
        return;
    }
    
    [self guard_insertString:aString atIndex:index];
}

@end
