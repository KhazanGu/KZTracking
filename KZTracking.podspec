#
# Be sure to run `pod lib lint KZTracking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KZTracking'
  s.version          = '0.0.1'
  s.summary          = 'A short description of KZTracking.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gujianxing/KZTracking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gujianxing' => 'Khazan.Gu@icloud.com' }
  s.source           = { :git => 'https://github.com/gujianxing/KZTracking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.subspec 'Basic' do |basic|
      
    basic.frameworks = 'UIKit'
    basic.source_files = 'KZTracking/Classes/Basic/*'

  end

  s.subspec 'UIViewController' do |vc|
      
    vc.frameworks = 'UIKit'
    vc.dependency 'Basic'
    vc.source_files = 'KZTracking/Classes/UIViewController/*'

  end

  s.subspec 'UIControl' do |c|
      
    c.frameworks = 'UIKit'
    c.dependency 'Basic'
    c.source_files = 'KZTracking/Classes/UIControl/*'

  end

  s.subspec 'UIApplication' do |app|
      
    app.frameworks = 'UIKit'
    app.dependency 'Basic'
    app.source_files = 'KZTracking/Classes/UIApplication/*'

  end

  s.subspec 'NSNotificationCenter' do |noti|
      
    noti.frameworks = 'UIKit'
    noti.dependency 'Basic'
    noti.source_files = 'KZTracking/Classes/NSNotificationCenter/*'

  end

#  s.subspec 'AFNetworking_3' do |afn_3|
#
#    afn_3.frameworks = 'UIKit'
#    afn_3.dependency 'Basic'
#    afn_3.dependency 'AFNetworking', '~> 3.0'
#    afn_3.source_files = 'KZTracking/Classes/AFNetworking_3/*'
#
#  end
  
#  s.subspec 'AFNetworking_4' do |afn_4|
#
#    afn_4.frameworks = 'UIKit'
#    afn_4.dependency 'Basic'
#    afn_4.dependency 'AFNetworking', '~> 4.0'
#    afn_4.source_files = 'KZTracking/Classes/AFNetworking_4/*'
#
#  end

  # s.resource_bundles = {
  #   'KZTracking' => ['KZTracking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
