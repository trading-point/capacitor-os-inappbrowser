require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = 'XmInappbrowser'
  s.version = package['version']
  s.summary = package['description']
  s.license = package['license']
  s.homepage = package['repository']['url']
  s.author = package['author']
  s.source = { :git => package['repository']['url'], :tag => s.version.to_s }
  s.source_files = 'ios/Sources/InAppBrowserPlugin/*.{swift,h,m,c,cc,mm,cpp}'
  s.ios.deployment_target  = '14.0'
  s.dependency 'OSInAppBrowserLib'
  s.dependency 'Capacitor'
  s.swift_version = '5.1'

  s.post_install do |installer|
    podfile_path = File.join(installer.sandbox.root, '../../Podfile')
    podfile_content = File.read(podfile_path)
    unless podfile_content.include?("pod 'OSInAppBrowserLib'")
      File.open(podfile_path, 'a') do |file|
        file.puts "\npod 'OSInAppBrowserLib', :git => 'https://github.com/trading-point/OSInAppBrowserLib-iOS.git', :tag => 'custom-headers'\n"
      end
    end
  end
end
