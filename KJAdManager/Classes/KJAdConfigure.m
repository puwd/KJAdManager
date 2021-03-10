//
//  KJAdConfigure.m
//  KJAdManager
//
//  Created by kaden Jack on 2021/3/9.
//

#import "KJAdConfigure.h"

#import "KJAdPangleManager.h"
#import "KJAdTencentAdnetManager.h"


static KJAdConfigure * adConfigure = nil;

@interface KJAdConfigure ()

/** app id */
@property(nonatomic, copy) NSString * appIDString;
/** banner id */
@property(nonatomic, copy) NSString * bannerIDString;
/** splash id */
@property(nonatomic, copy) NSString * splashIDString;
/** fullScreen id */
@property(nonatomic, copy) NSString * fullScreenIDString;
/** rewarded id */
@property(nonatomic, copy) NSString * rewardedIDString;
/** inster id */
@property(nonatomic, copy) NSString * insterIDString;
/** draw id */
@property(nonatomic, copy) NSString * drawIDString;

@end

@implementation KJAdConfigure

+ (KJAdConfigure *)configure {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adConfigure = [[self alloc] init];
    });
    return adConfigure;
}

- (NSString *)getAdIDWithPlatform:(KJAdPlatform)platform adType:(KJAdType)adType {
    NSString * platformString = @"";
    switch (platform) {
        case KJAdPlatformPangle:
            platformString = @"KJPangle_";
            break;
        case KJAdPlatformTencentAdnet:
            platformString = @"KJAdnet_";
            break;
        case KJAdPlatformAdmob:
            platformString = @"KJAdmob_";
            break;
    }
    NSString * typeString = @"";
    switch (adType) {
        case KJAdTypeBanner:
            typeString = @"BannerID";
            break;
        case KJAdTypeSplash:
            typeString = @"SplashID";
            break;
        case KJAdTypeFullScreen:
            typeString = @"FullScreenID";
            break;
        case KJAdTypeRewarded:
            typeString = @"RewardedID";
            break;
        case KJAdTypeInster:
            typeString = @"InsterID";
            break;
        case KJAdTypeDraw:
            typeString = @"DrawID";
            break;
    }
    NSString * keyString = [platformString stringByAppendingFormat:@"%@",typeString];
    return [[NSUserDefaults standardUserDefaults] stringForKey:keyString];
}

#pragma mark - 保存所有平台信息
- (void)saveAllPlatformIDWithPlatform:(NSString *)platform {
    [[NSUserDefaults standardUserDefaults] setObject:self.bannerIDString forKey:[NSString stringWithFormat:@"%@BannerID",platform]];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.splashIDString forKey:[NSString stringWithFormat:@"%@SplashID",platform]];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.fullScreenIDString forKey:[NSString stringWithFormat:@"%@FullScreenID",platform]];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.rewardedIDString forKey:[NSString stringWithFormat:@"%@RewardedID",platform]];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.insterIDString forKey:[NSString stringWithFormat:@"%@InsterID",platform]];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.drawIDString forKey:[NSString stringWithFormat:@"%@DrawID",platform]];
    
    self.appIDString        = @"";
    self.bannerIDString     = @"";
    self.splashIDString     = @"";
    self.fullScreenIDString = @"";
    self.rewardedIDString   = @"";
    self.insterIDString     = @"";
    self.drawIDString       = @"";
}

#pragma mark - 配置穿山甲ID
- (KJAdConfigure * _Nonnull (^)(void))configurePangle {
    return ^{
        [[KJAdPangleManager shareUtils] configureAppIDWithAppID:self.appIDString];
        /// 保存所有ID信息
        [self saveAllPlatformIDWithPlatform:@"KJPangle_"];
        
        return self;
    };
}

#pragma mark - 配置优量汇ID
- (KJAdConfigure * _Nonnull (^)(void))congifureTencentAdnet {
    return ^{
        [[KJAdTencentAdnetManager shareUtils] configureAppIDWithAppID:self.appIDString];
        
        /// 保存所有ID信息
        [self saveAllPlatformIDWithPlatform:@"KJAdnet_"];
        
        return self;
    };
}

#pragma mark - 链式方法
- (KJAdConfigure * _Nonnull (^)(NSString * _Nonnull))appID {
    return ^(NSString * appID) {
        self.appIDString = appID;
        return self;
    };
}

- (KJAdConfigure * _Nonnull (^)(NSString * _Nonnull))bannerID {
    return ^(NSString * bannerID) {
        self.bannerIDString = bannerID;
        return self;
    };
}

- (KJAdConfigure * _Nonnull (^)(NSString * _Nonnull))splashID {
    return ^(NSString * splashID) {
        self.splashIDString = splashID;
        return self;
    };
}

- (KJAdConfigure * _Nonnull (^)(NSString * _Nonnull))fullScreenID {
    return ^(NSString * fullScreenID) {
        self.fullScreenIDString = fullScreenID;
        return self;
    };
}

- (KJAdConfigure * _Nonnull (^)(NSString * _Nonnull))rewardedID {
    return ^(NSString * rewardedID) {
        self.rewardedIDString = rewardedID;
        return self;
    };
}

- (KJAdConfigure * _Nonnull (^)(NSString * _Nonnull))insterID {
    return ^(NSString * insterID) {
        self.insterIDString = insterID;
        return self;
    };
}

- (KJAdConfigure * _Nonnull (^)(NSString * _Nonnull))drawID {
    return ^(NSString * drawID) {
        self.drawIDString = drawID;
        return self;
    };
}


@end
