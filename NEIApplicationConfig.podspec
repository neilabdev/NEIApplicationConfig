#
# Be sure to run `pod lib lint NEIApplicationConfig.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NEIApplicationConfig'
  s.version          = '1.0.1'
  s.summary          = 'Allows custom configurations defined in a config file per environment and or bundle identifier,
which makes deployment and testing easier.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
NEIApplicationConfig allows developers to have configurations defined in a config file per environment & bundle identifier,
which makes deployment and testing multiple versions easier. While usage of application properties via .plist is useful,
NEIApplicationConfig allows you can easily target Simulator, Device and Production 
environments respectively, in addition to overrides specific to a bundle identifier, e.g. Production, Beta, Adhoc, etc. 
With NEIApplicationConfig, you will specify a default configuration as a baseline, and overrides that are 
pertinent to their respective circumstances.
                       DESC

  s.homepage         = 'https://github.com/neilabdev/NEIApplicationConfig'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ghost' => 'ghost@neilab.com' }
  s.source           = { :git => 'https://github.com/neilabdev/NEIApplicationConfig.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NEIApplicationConfig/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NEIApplicationConfig' => ['NEIApplicationConfig/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
