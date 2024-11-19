#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ontrace_flutter_plugin.podspec --allow-warnings` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ontrace_flutter_plugin'
  s.version          = '0.0.7'
  s.summary          = 'A new Flutter plugin project.'
  s.summary          = 'An SDK to identify a user basedon their ID and face scan'
  s.description      = 'An SDK to identify a user basedon their ID and face scan using Qoobiss'
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'MIT', :file => '../../ontrace_flutter_plugin/LICENSE' }
  s.author           = { 'Qoobiss' => 'vlad.buhaescu@qoobiss.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'

  s.dependency 'Flutter'
  s.dependency 'OntraceSDK', '~> 0.0.7'

  s.platform = :ios, '14.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
