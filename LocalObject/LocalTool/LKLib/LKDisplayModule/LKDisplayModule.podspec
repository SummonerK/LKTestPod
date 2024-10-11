#
# Be sure to run `pod lib lint LKDisplayModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LKDisplayModule'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LKDisplayModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/luofei/LKDisplayModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luofei' => 'solluffy@163.com' }
  s.source           = { :git => 'https://github.com/luofei/LKDisplayModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'LKDisplayModule/Classes/**/*.{swift,h,m}'
  s.resource_bundles = {
      'LKDisplayModule' => ['LKDisplayModule/Assets/*.bundle', 'LKDisplayModule/Assets/*.xcassets','LKDisplayModule/Assets/*.json','LKDisplayModule/Assets/*.svga']
  }
  
  # s.resource_bundles = {
  #   'LKDisplayModule' => ['LKDisplayModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
   s.dependency 'Masonry'
   s.dependency 'YYText'
   s.dependency 'LKUtils'
#   s.dependency 'SJVideoPlayer'
   s.dependency 'SJUIKit/SQLite3'
   s.dependency 'SJMediaCacheServer'
   s.dependency 'SVGAPlayer'
   
   
   s.dependency 'LKGlobalization'
   s.dependency 'LKIconFontKit'
   
   
end
