#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint anti_screenshot_guard.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'anti_screenshot_guard'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin to prevent screenshots and detect screenshot events.'
  s.description      = <<-DESC
A Flutter plugin to prevent screenshots and detect screenshot events on Android and iOS.
                       DESC
  s.homepage         = 'https://github.com/pancanugraha/anti_screenshot_guard'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Panca Nugraha' => 'panca@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end