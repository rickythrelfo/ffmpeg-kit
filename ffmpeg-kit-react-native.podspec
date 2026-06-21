require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "ffmpeg-kit-react-native"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platform          = :ios
  s.ios.deployment_target = '15.1'
  s.requires_arc      = true
  s.static_framework  = true

  # s.source       = { :git => "https://github.com/userkr/ffmpeg-kit-react-native.git", :tag => "react.native.v#{s.version}" }

  # s.default_subspec   = 'https'

  # 1. Исправьте источник (source). Укажите путь к вашему собственному релизу.
  s.source = {
    :http => "https://github.com/rickythrelfo/ffmpeg-kit/releases/download/v1.0.0/ffmpegkit-ios.xcframework.zip"
  }

  s.dependency "React-Core"

  # 2. Добавьте ВСЕ фреймворки в vendored_frameworks.
  s.vendored_frameworks = [
      "ffmpegkit.xcframework",
      "libavcodec.xcframework",
      "libavformat.xcframework",
      "libavutil.xcframework",
      "libswscale.xcframework",
      "libswresample.xcframework",
      "libavfilter.xcframework",
      "libavdevice.xcframework"
  ]

  s.source_files = [
    "ios/FFmpegKitReactNativeModule.m",
    "ios/FFmpegKitReactNativeModule.h"
  ]

  # === ИЗМЕНЕНИЕ 3: Добавляем необходимые системные фреймворки и библиотеки ===
  s.frameworks = [
    "AudioToolbox",
    "AVFoundation",
    "VideoToolbox"
  ]
  
  s.libraries = [
    "bz2",
    "iconv",
    "z"
  ]

  # === ИЗМЕНЕНИЕ 4: Настройки для корректной работы архитектур ===
  s.pod_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) OS_OBJECT_USE_OBJC=1',
    'VALID_ARCHS' => 'arm64 x86_64 arm64-simulator',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'OTHER_LDFLAGS' => '-framework ffmpegkit -framework libavcodec -framework libavformat -framework libavutil -framework libswscale -framework libswresample -framework libavfilter -framework libavdevice'
  }
  
  # s.subspec 'https' do |ss|
  #     ss.source_files      = '**/FFmpegKitReactNativeModule.m',
  #                            '**/FFmpegKitReactNativeModule.h'
  #     ss.dependency 'ffmpeg-kit-https', "1.0"
  #     ss.ios.deployment_target = '12.1'
  # end
end
