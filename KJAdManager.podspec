#
# Be sure to run `pod lib lint KJAdManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KJAdManager'
  s.version          = '0.1.0'
  s.summary          = 'A short description of KJAdManager.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/kaden Jack/KJAdManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kaden Jack' => 'dongyx' }
  s.source           = { :git => 'https://github.com/kaden Jack/KJAdManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  # 允许安装静态库
  s.static_framework = true

  s.source_files = 'KJAdManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KJAdManager' => ['KJAdManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Ads-CN'       # 3.4.2.8
  s.dependency 'GDTMobSDK'    # 4.12.3
  s.dependency 'MMKV'
end
