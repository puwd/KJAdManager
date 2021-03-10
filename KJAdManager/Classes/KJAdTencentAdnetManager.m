//
//  KJAdTencentAdnetManager.m
//  KJAdManager
//
//  Created by kaden Jack on 2021/3/9.
//

#import "KJAdTencentAdnetManager.h"
#import "KJAdConfigure.h"
#import "GDTSDKConfig.h"

static KJAdTencentAdnetManager * manager = nil;

@implementation KJAdTencentAdnetManager

+ (KJAdTencentAdnetManager *)shareUtils {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - 配置AppID
- (void)configureAppIDWithAppID:(NSString *)appID {
    /// 配置 appid
    [GDTSDKConfig registerAppId:appID];
    /// 设置渠道号
    [GDTSDKConfig setChannel:14];
}

#pragma mark - 检查广告位ID是否为空
- (void)checkIDWithIDString:(NSString *)idString {
    if (idString == nil || [idString isEqualToString:@""]) {
        NSAssert(true, @"广告位ID不能为空");
    }
}

@end

#pragma mark - 优量汇 - 开屏
@interface KJAdTencentAdnetManager (Splash)

@end

@implementation KJAdTencentAdnetManager (Splash)

- (void)showSplashView {
    
}

@end
