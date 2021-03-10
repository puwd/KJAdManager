//
//  KJAdTencentAdnetManager.h
//  KJAdManager
//
//  Created by kaden Jack on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import "KJAdManager.h"

NS_ASSUME_NONNULL_BEGIN

/** 优量汇管理 */
@interface KJAdTencentAdnetManager : NSObject

+ (KJAdTencentAdnetManager *)shareUtils;

@property(nonatomic, copy) KJAdStatusBlock statusBlock;

- (void)configureAppIDWithAppID:(NSString *)appID;

/** 检查广告位ID是否为空 */
- (void)checkIDWithIDString:(NSString *)idString;

@end


#pragma mark - 优量汇 - 开屏
@interface KJAdTencentAdnetManager (Splash)

/** 将自动展示开屏广告（全屏展示） */
- (void)showSplashView;

/** 自定义广告位置 */
- (void)showSplashViewWithAdFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
