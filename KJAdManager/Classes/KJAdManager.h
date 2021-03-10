//
//  KJAdManager.h
//  KJAdManager
//
//  Created by kaden Jack on 2021/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 广告平台 */
typedef enum : NSUInteger {
    /** 穿山甲 */
    KJAdPlatformPangle,
    /** 腾讯优量汇 */
    KJAdPlatformTencentAdnet,
    /** google 联盟(尚未配置) */
    KJAdPlatformAdmob,
} KJAdPlatform;

/** 广告类型 */
typedef enum : NSUInteger {
    /** 开屏 */
    KJAdTypeSplash,
    /** banner */
    KJAdTypeBanner,
    /** 全屏视频 */
    KJAdTypeFullScreen,
    /** 激励视频 */
    KJAdTypeRewarded,
    /** 视频流 */
    KJAdTypeDraw,
    /** 插屏 */
    KJAdTypeInster,
} KJAdType;

/** 广告状态 */
typedef enum : NSUInteger {
    /** 开始加载 */
    KJAdStatusStartLoad,
    /** 加载中 */
    KJAdStatusLoading,
    /** 加载成功 */
    KJAdStatusLoadSuccess,
    /** 加载失败 */
    KJAdStatusLoadFail,
    /** 准备展示 */
    KJAdStatusWillShow,
    /** 展示中 */
    KJAdStatusShowing,
    /** 点击 */
    KJAdStatusDidClick,
    /** 即将关闭 */
    KJAdStatusWillClose,
    /** 关闭 */
    KJAdStatusClose
} KJAdStatus;

/** 广告状态回调 */
typedef void(^KJAdStatusBlock)(KJAdType adType,KJAdStatus adStatus, NSError * _Nullable error);

@interface KJAdManager : NSObject

+ (KJAdManager *)shareUtils;

@property(nonatomic, copy) KJAdStatusBlock statusBlock;

/** 获取当前控制器 */
- (UIViewController *)currentController;

@end

NS_ASSUME_NONNULL_END
