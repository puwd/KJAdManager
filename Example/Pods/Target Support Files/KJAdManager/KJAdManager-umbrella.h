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

#import "KJAdConfigure.h"
#import "KJAdManager.h"
#import "KJAdPangleManager.h"
#import "KJAdTencentAdnetManager.h"

FOUNDATION_EXPORT double KJAdManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char KJAdManagerVersionString[];

