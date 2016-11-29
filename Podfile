platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def shared_pods
  pod 'RxSwift',    '~> 3.0'
  pod 'RxCocoa',    '~> 3.0'
  pod 'R.swift'
  pod 'SnapKit', :git => 'https://github.com/SnapKit/SnapKit', :commit => '02a0b2d2b7303782ce348869c12e67a9d5f019b9'
  pod 'ObjectMapper', '2.2.0'
  pod 'Kingfisher', '3.1.4'
  pod 'Alamofire', '4.0.1'
  
  # pod 'Bugly', '2.4.2'
  # pod 'libWeChatSDK', '1.7.1'
  pod 'SlideMenuControllerSwift'
end

target 'iOS-Startup' do
  shared_pods 
end 
