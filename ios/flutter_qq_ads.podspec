#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_qq_ads.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_qq_ads'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
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
  
  s.ios.deployment_target = '9.0'
  # Flutter.framework does not contain a i386 slice.
#  s.pod_target_xcconfig = {'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
