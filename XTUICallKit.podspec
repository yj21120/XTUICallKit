
Pod::Spec.new do |s|
  s.name             = 'XTUICallKit'
  s.version          = '0.1.33'
  s.summary          = 'XTUICallKit.'

  s.homepage         = 'https://github.com/yj21120/XTUICallKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yj' => '-' }
  s.source           = { :git => 'https://github.com/yj21120/XTUICallKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.xcconfig     = { 'VALID_ARCHS' => 'armv7 arm64 x86_64' }
  
  s.requires_arc = true
  s.static_framework = true
  
  s.dependency 'Masonry'
  s.dependency 'TUICore', '~>7.1.3925'
  s.dependency 'lottie-ios', '~> 3.2.3'  #, '~>2.5.3'
  s.dependency 'ZipArchive'
  s.dependency 'Moya'
 
 
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.swift_version = '5.0'
  s.default_subspec = 'Professional'
  
#  s.subspec 'TRTC' do |trtc|
#    trtc.dependency 'TXLiteAVSDK_TRTC'
#    trtc.dependency 'TUICallEngine/TRTC', '~> 1.5.1.310'
#    trtc.source_files = 'TUICallKit/*.{h,m,mm,swift}', 'TUICallKit/localized/**/*.{h,m,mm}', 'TUICallKit/Base/*.{h,m,mm}', 'TUICallKit/Service/**/*.{h,m,mm}', 'TUICallKit/Config/*.{h,m,mm}', 'TUICallKit/UI/**/*.{h,m,mm}', 'TUICallKit/TUICallKit_TRTC/*.{h,m,mm}', 'TUICallKit/TUICallEngine_Framework/*.{h,m,mm}'
#    trtc.ios.framework = ['AVFoundation', 'Accelerate']
#    trtc.library = 'c++', 'resolv','sqlite3'
#    trtc.resource_bundles = {
#      'TUICallingKitBundle' => ['Resources/Localized/**/*.gif','Resources/Localized/**/*.strings', 'Resources/AudioFile', 'Resources/*.xcassets']
#    }
#  end

  s.subspec 'Professional' do |professional|
    professional.dependency 'TXLiteAVSDK_Professional'
    professional.dependency 'TUICallEngine/Professional'
    professional.source_files = 'TUICallKit/*.{h,m,mm,swift}', 'TUICallKit/localized/**/*.{h,m,mm}', 'TUICallKit/Base/*.{h,m,mm}', 'TUICallKit/Service/**/*.{h,m,mm}', 'TUICallKit/Config/*.{h,m,mm}', 'TUICallKit/UI/**/*.{h,m,mm}', 'TUICallKit/TUICallKit_Professional/*.{h,m,mm}', 'TUICallKit/TUICallEngine_Framework/*.{h,m,mm}'
    professional.ios.framework = ['AVFoundation', 'Accelerate', 'AssetsLibrary']
    professional.library = 'c++', 'resolv', 'sqlite3'
    professional.resource_bundles = {
      'TUICallingKitBundle' => ['Resources/Localized/**/*.gif','Resources/Localized/**/*.strings', 'Resources/AudioFile', 'Resources/*.xcassets']
    }
  end
end
