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

#import "GHLShareLifecycle.h"
#import "LBApplicationDelegate.h"
#import "LBLifecycle.h"

FOUNDATION_EXPORT double GHLShareLifecycleVersionNumber;
FOUNDATION_EXPORT const unsigned char GHLShareLifecycleVersionString[];

