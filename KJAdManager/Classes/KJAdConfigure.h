//
//  KJAdConfigure.h
//  KJAdManager
//
//  Created by kaden Jack on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import "KJAdManager.h"

NS_ASSUME_NONNULL_BEGIN


@interface KJAdConfigure : NSObject

+ (KJAdConfigure *)configure;

/** setup pangle */
- (KJAdConfigure *(^)(void))configurePangle;

/** setup Tencent-adNet */
- (KJAdConfigure *(^)(void))congifureTencentAdnet;


/// get ad id
/// @param platform platform
/// @param adType type
- (NSString *)getAdIDWithPlatform:(KJAdPlatform)platform adType:(KJAdType)adType;

/// appid
- (KJAdConfigure *(^)(NSString *))appID;
/** banner id */
- (KJAdConfigure *(^)(NSString *))bannerID;
/** splash id */
- (KJAdConfigure *(^)(NSString *))splashID;
/** rewarded id */
- (KJAdConfigure *(^)(NSString *))rewardedID;
/** fullScreen id */
- (KJAdConfigure *(^)(NSString *))fullScreenID;
/** inster id */
- (KJAdConfigure *(^)(NSString *))insterID;
/** draw id */
- (KJAdConfigure *(^)(NSString *))drawID;

@end

NS_ASSUME_NONNULL_END
