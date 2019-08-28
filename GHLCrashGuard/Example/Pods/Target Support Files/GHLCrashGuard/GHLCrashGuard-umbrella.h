#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSArray+GHLCrashGuard.h"
#import "NSDictionary+GHLCrashGuard.h"
#import "NSMutableArray+GHLCrashGuard.h"
#import "NSMutableDictionary+GHLCrashGuard.h"
#import "NSMutableString+GHLCrashGuard.h"
#import "NSNumber+GHLCrashGuard.h"
#import "NSString+GHLCrashGuard.h"
#import "GHLCrashGuardProxy.h"
#import "NSObject+GHLCrashGuard.h"
#import "GHLBadAccessManager.h"
#import "GHLZoombie.h"
#import "GHLCrashGuard.h"
#import "GHLNotificationCenterManager.h"
#import "NSNotificationCenter+GHLCrashGuard.h"
#import "GHLUnrecognizedSelectorManager.h"

FOUNDATION_EXPORT double GHLCrashGuardVersionNumber;
FOUNDATION_EXPORT const unsigned char GHLCrashGuardVersionString[];

