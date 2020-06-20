#
# Be sure to run `pod lib lint YXWListBinder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YXWListBinder'
  s.version          = '0.2.37'
  s.summary          = 'List binder.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xiaowinner/YXWListBinder'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '原晓文' => 'yuanxiao225@icloud.com' }
  s.source           = { :git => 'https://github.com/xiaowinner/YXWListBinder.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'YXWListBinder/Classes/**/*'
  
  s.resource_bundles = {
      'YXWListBinder' => ['YXWListBinder/Assets/**']
  }

  s.dependency 'ReactiveCocoa', '~> 2.5'

end
