#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_qq_ads.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_qq_ads'
  s.version          = '2.5.0'
  s.summary          = '一款优质的 Flutter 广告插件（腾讯广告、广点通、优量汇）'
  s.description      = <<-DESC
  一款优质的 Flutter 广告插件（腾讯广告、广点通、优量汇）.
                       DESC
  s.homepage         = 'https://github.com/FlutterAds'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ZeroFlutter' => '1300326388@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'GDTMobSDK'
  s.static_framework = true
  # 广点通的 SDK 最低支持 9.0 所以，这里设置 9.0
  s.ios.deployment_target = '9.0'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
