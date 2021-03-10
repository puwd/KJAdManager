//
//  KJAdPangleManager.m
//  KJAdManager
//
//  Created by kaden Jack on 2021/3/9.
//

#import "KJAdPangleManager.h"
#import "KJAdConfigure.h"
#import <BUAdSDK/BUAdSDK.h>

static KJAdPangleManager * manager = nil;

@implementation KJAdPangleManager

+ (KJAdPangleManager *)shareUtils {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - 配置AppID
- (void)configureAppIDWithAppID:(NSString *)appID {
    /// 配置 appid
    [BUAdSDKManager setAppID:appID];
    // 关闭Log打印
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelNone];
    // 是否设置为iPaid app
    [BUAdSDKManager setIsPaidApp:false];
}

#pragma mark - 检查广告位ID是否为空
- (void)checkIDWithIDString:(NSString *)idString {
    if (idString == nil || [idString isEqualToString:@""]) {
        NSAssert(true, @"广告位ID不能为空");
    }
}

@end


#pragma mark - 穿山甲 - 开屏
@interface KJAdPangleManager(Splash) <BUSplashAdDelegate>

@end


@implementation KJAdPangleManager (Splash)

- (void)showSplashView {
    [self showSplashViewWithAdFrame:[UIScreen mainScreen].bounds];
}

- (void)showSplashViewWithAdFrame:(CGRect)frame {
    NSString * splashID = [KJAdConfigure.configure getAdIDWithPlatform:KJAdPlatformPangle adType:KJAdTypeSplash];
    [self checkIDWithIDString:splashID];
    BUSplashAdView * splashView = [[BUSplashAdView alloc] initWithSlotID:splashID frame:frame];
    splashView.delegate = self;
    [splashView loadAdData];
}


#pragma mark - BUSplashAdDelegate
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusLoadSuccess, nil);
    }
    UIViewController * currentController = [[KJAdManager shareUtils] currentController];
    [currentController.view addSubview:splashAd];
    splashAd.rootViewController = currentController;
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    [splashAd removeFromSuperview];
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusLoadFail, error);
    }
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusWillShow, nil);
    }
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusDidClick, nil);
    }
}

- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusWillClose, nil);
    }
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    [splashAd removeFromSuperview];
    splashAd.delegate = nil;
    splashAd = nil;
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusClose, nil);
    }
}

@end



#pragma mark - 穿山甲 - Banner
@interface KJAdPangleManager (Banner)<BUNativeExpressBannerViewDelegate>

@end

@implementation KJAdPangleManager (Banner)

- (BUNativeExpressBannerView *)showBannerViewWithAdSize:(CGSize)adSize {
    return [self showBannerViewWithAdSize:adSize interval:30];
}

- (BUNativeExpressBannerView *)showBannerViewWithAdSize:(CGSize)adSize interval:(int)interval {
    
    UIViewController * currentController = [KJAdManager.shareUtils currentController];
    NSString * bannerID = [KJAdConfigure.configure getAdIDWithPlatform:KJAdPlatformPangle adType:KJAdTypeBanner];
    [self checkIDWithIDString:bannerID];
    BUNativeExpressBannerView * bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:bannerID rootViewController:currentController adSize:adSize interval:interval];
    bannerView.delegate = self;
    [bannerView loadAdData];
    return bannerView;
}

#pragma mark - BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusDidClick, nil);
    }
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusLoadFail, error);
    }
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeBanner, KJAdStatusLoadSuccess, nil);
    }
}

@end



#pragma mark - 全屏视频
@interface KJAdPangleManager (FullScreen)<BUNativeExpressFullscreenVideoAdDelegate>

@end

@implementation KJAdPangleManager (FullScreen)

- (BUNativeExpressFullscreenVideoAd *)loadFullScreenVideo {
    
    NSString * fullScreenID = [KJAdConfigure.configure getAdIDWithPlatform:KJAdPlatformPangle adType:KJAdTypeFullScreen];
    [self checkIDWithIDString:fullScreenID];
    
    BUNativeExpressFullscreenVideoAd * fullScreenVideo = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:fullScreenID];
    fullScreenVideo.delegate = self;
    [fullScreenVideo loadAdData];
    
    return fullScreenVideo;
}

- (void)showFullScreenVideo:(BUNativeExpressFullscreenVideoAd *)fullScreenVideo {
    UIViewController * currentController = [KJAdManager.shareUtils currentController];
    [fullScreenVideo showAdFromRootViewController:currentController];
}

#pragma mark - BUNativeExpressFullscreenVideoAdDelegate
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeFullScreen, KJAdStatusStartLoad, nil);
    }
}

- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeFullScreen, KJAdStatusLoadFail, error);
    }
}

- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeFullScreen, KJAdStatusDidClick, nil);
    }
}

- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeFullScreen, KJAdStatusClose, nil);
    }
}

- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeFullScreen, KJAdStatusLoadSuccess, nil);
    }
}

- (void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *)error {
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeFullScreen, KJAdStatusLoadFail, error);
    }
}

@end


#pragma mark - 激励视频
@interface KJAdPangleManager (Rewarded)<BUNativeExpressRewardedVideoAdDelegate>

@end

@implementation KJAdPangleManager (Rewarded)

- (BUNativeExpressRewardedVideoAd *)loadRewardedVideo {
    
    NSString * rewardedID = [KJAdConfigure.configure getAdIDWithPlatform:KJAdPlatformPangle adType:KJAdTypeRewarded];
    [self checkIDWithIDString:rewardedID];
    
    BURewardedVideoModel * model = [[BURewardedVideoModel alloc] init];
    model.userId = @"1243";
    BUNativeExpressRewardedVideoAd * rewardedVideo = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:rewardedID rewardedVideoModel:model];
    rewardedVideo.delegate = self;
    [rewardedVideo loadAdData];
    
    return rewardedVideo;
}

- (void)showRewardedVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideo {
    UIViewController * currentController = [KJAdManager.shareUtils currentController];
    [rewardedVideo showAdFromRootViewController:currentController];
}

#pragma mark - BUNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeRewarded, KJAdStatusLoadSuccess, nil);
    }
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeRewarded, KJAdStatusLoadFail, error);
    }
}

- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeRewarded, KJAdStatusWillClose, nil);
    }
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeRewarded, KJAdStatusClose, nil);
    }
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeRewarded, KJAdStatusDidClick, nil);
    }
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeRewarded, KJAdStatusLoadFail, error);
    }
}

@end



#pragma mark - Inster Ad
@interface KJAdPangleManager (Inster)<BUNativeExpresInterstitialAdDelegate>

@end


@implementation KJAdPangleManager (Inster)

- (BUNativeExpressInterstitialAd *)loadInsterAdWithAdSize:(CGSize)adSize {
    
    NSString * insterID = [KJAdConfigure.configure getAdIDWithPlatform:KJAdPlatformPangle adType:KJAdTypeInster];
    [self checkIDWithIDString:insterID];
    
    BUNativeExpressInterstitialAd * insterAD = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:insterID adSize:adSize];
    insterAD.delegate = self;
    [insterAD loadAdData];
    return insterAD;
}

- (void)showInsterAd:(BUNativeExpressInterstitialAd *)insterAd {
    UIViewController * currentController = [KJAdManager.shareUtils currentController];
    [insterAd showAdFromRootViewController:currentController];
}

#pragma mark - BUNativeExpresInterstitialAdDelegate
- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeInster, KJAdStatusLoadSuccess, nil);
    }
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeInster, KJAdStatusDidClick, nil);
    }
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeInster, KJAdStatusClose, nil);
    }
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeInster, KJAdStatusLoadFail, error);
    }
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeInster, KJAdStatusLoadFail, error);
    }
}

@end

#pragma mark - 流视频
@interface KJAdPangleManager (DrawVideo)<BUNativeExpressAdViewDelegate>

@property(nonatomic, copy) void(^adSourceBlock)(NSArray<BUNativeExpressAdView *> *);

@end

@implementation KJAdPangleManager (DrawVideo)

- (void)loadDrawVideoWithAdSourceBlock:(void (^)(NSArray<BUNativeExpressAdView *> * _Nonnull))adSourceBlock {
    [self loadDrawVideoWithVideoCount:1 adSourceBlock:adSourceBlock];
}

- (void)loadDrawVideoWithVideoCount:(int)videoCount adSourceBlock:(void (^)(NSArray<BUNativeExpressAdView *> * _Nonnull))adSourceBlock {
    
    self.adSourceBlock = adSourceBlock;
    
    NSString * drawID = [KJAdConfigure.configure getAdIDWithPlatform:KJAdPlatformPangle adType:KJAdTypeDraw];
    [self checkIDWithIDString:drawID];
    
    BUAdSlot * adSlot = [[BUAdSlot alloc] init];
    adSlot.ID = drawID;
    adSlot.AdType = BUAdSlotAdTypeDrawVideo;
    adSlot.isOriginAd = true;
    adSlot.imgSize = [BUSize sizeBy:BUProposalSize_DrawFullScreen];
    
    BUNativeExpressAdManager * drawAd = [[BUNativeExpressAdManager alloc] initWithSlot:adSlot adSize:[UIScreen mainScreen].bounds.size];
    drawAd.delegate = self;
    [drawAd loadAdDataWithCount:videoCount];
}

#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    UIViewController * currentController = [KJAdManager.shareUtils currentController];
    
    NSMutableArray * videoArray = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < views.count; i++) {
        BUNativeExpressAdView * adView = views[i];
        adView.rootViewController = currentController;
        [adView render];
        [videoArray addObject:adView];
    }
    
    if (self.adSourceBlock) {
        self.adSourceBlock(videoArray);
    }
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *)error {
    if (self.statusBlock && error) {
        self.statusBlock(KJAdTypeDraw, KJAdStatusLoadFail, error);
    }
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeDraw, KJAdStatusLoadSuccess, nil);
    }
}

- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    [nativeExpressAdView render];
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.statusBlock) {
        self.statusBlock(KJAdTypeDraw, KJAdStatusWillShow, nil);
    }
}

@end
