//
//  KJAdPangleManager.h
//  KJAdManager
//
//  Created by kaden Jack on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import "KJAdManager.h"

NS_ASSUME_NONNULL_BEGIN

/** 穿山甲管理 */
@class BUNativeExpressBannerView;
@class BUNativeExpressFullscreenVideoAd;
@class BUNativeExpressRewardedVideoAd;
@class BUNativeExpressInterstitialAd;
@class BUNativeExpressAdView;
@interface KJAdPangleManager : NSObject

+ (KJAdPangleManager *)shareUtils;

@property(nonatomic, copy) KJAdStatusBlock statusBlock;

/** 配置appID */
- (void)configureAppIDWithAppID:(NSString *)appID;

/** 检查广告位ID是否为空 */
- (void)checkIDWithIDString:(NSString *)idString;

@end


#pragma mark - 穿山甲 - 开屏
@interface KJAdPangleManager (Splash)

/** 将自动展示开屏广告（全屏展示） */
- (void)showSplashView;

/** 自定义广告位置 */
- (void)showSplashViewWithAdFrame:(CGRect)frame;

@end

#pragma mark - 穿山甲 - Banner
@interface KJAdPangleManager (Banner)

/// 展示Banner (默认每30秒刷新一次)
/// @param adSize 广告大小
- (BUNativeExpressBannerView *)showBannerViewWithAdSize:(CGSize)adSize;

/// 展示Banner
/// @param adSize 广告大小
/// @param interval 刷新频率
- (BUNativeExpressBannerView *)showBannerViewWithAdSize:(CGSize)adSize interval:(int)interval;

@end


#pragma mark - 全屏视频
@interface KJAdPangleManager (FullScreen)

/** 加载全屏视频 */
- (BUNativeExpressFullscreenVideoAd *)loadFullScreenVideo;

/// 展示全屏视频
/// @param fullScreenVideo 视频模型
- (void)showFullScreenVideo:(BUNativeExpressFullscreenVideoAd *)fullScreenVideo;

@end

#pragma mark - 激励视频
@interface KJAdPangleManager (Rewarded)

/** 加载激励视频 */
- (BUNativeExpressRewardedVideoAd *)loadRewardedVideo;

/** 展示激励视频 */
- (void)showRewardedVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideo;

@end

#pragma mark - 插屏广告
@interface KJAdPangleManager (Inster)

/// 加载插屏广告
/// @param adSize 广告位大小
- (BUNativeExpressInterstitialAd *)loadInsterAdWithAdSize:(CGSize)adSize;

/// 展示广告位
/// @param insterAd 插屏模型
- (void)showInsterAd:(BUNativeExpressInterstitialAd *)insterAd;

@end

#pragma mark - 流视频
@interface KJAdPangleManager (DrawVideo)

/// 获取流视频
/// @param videoCount 视频数量
/// @param adSourceBlock 视频数据回调
- (void)loadDrawVideoWithVideoCount:(int)videoCount adSourceBlock:(void(^)(NSArray <BUNativeExpressAdView *> *))adSourceBlock;

/// 获取流视频
/// @param adSourceBlock 视频数据回调
- (void)loadDrawVideoWithAdSourceBlock:(void(^)(NSArray <BUNativeExpressAdView *> *))adSourceBlock;

@end

NS_ASSUME_NONNULL_END
