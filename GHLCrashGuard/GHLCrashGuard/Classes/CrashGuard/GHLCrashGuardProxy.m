//
//  GHLCrashGuardProxy.m
//  GHLCrashGuard
//
//  Created by 与佳期 on 2019/7/9.
//

#import "GHLCrashGuardProxy.h"
#import <objc/runtime.h>
#include <execinfo.h>

@implementation GHLCrashGuardProxy

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, imp_implementationWithBlock(^{
        // 收集堆栈，上报 Crash
        // NSLog(@"%@", [NSThread callStackSymbols]);
        
        void *callstack[128];
        int frames = backtrace(callstack, 128);
        char **strs = backtrace_symbols(callstack, frames);
        NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
        for (int i = 0; i < frames; i++) {
            [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
        }
        free(strs);
        NSLog(@"backtrace:%@", backtrace);
        
        return nil;
    }), "@@:");
    return YES;
}

@end
