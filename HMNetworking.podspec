Pod::Spec.new do |s|
  s.name = 'HMNetworking'
  s.version = '1.0.2'
  s.summary = 'Declarative network framework'
  s.homepage = 'https://github.com/ArchiProger/HMNetworking'
  s.author = { 'Danilov Arthur' => 'danilov985@icloud.com' }
  s.license = { :type => 'MIT', :file => 'LICENSE' }

  s.dependency 'Alamofire'
  s.source_files = 'Sources/**/*.{h,m,swift}'  
  s.source = { :git => 'https://github.com/ArchiProger/HMNetworking.git', :tag => '1.0.2' }

  s.swift_versions = ['5']
  
  s.ios.deployment_target = '13'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13'
  s.watchos.deployment_target = '6'
end

