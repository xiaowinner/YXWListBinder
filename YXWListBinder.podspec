#
# Be sure to run `pod lib lint YXWListBinder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YXWListBinder'
  s.version          = '0.2.13'
  s.summary          = 'List binder.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

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

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'CHTCollectionViewWaterfallLayout'
  # s.prefix_header_contents = '#import "YXWListBinder.h"'
  s.dependency 'ReactiveCocoa', '~> 2.5'

end
