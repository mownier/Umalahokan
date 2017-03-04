platform :ios, '9.0'
use_frameworks!

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

def shared_pods
  pod 'Firebase'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git', :tag => '3.1.1'
  pod 'DateTools'
  pod 'DKChainableAnimationKit', :git => 'https://github.com/Draveness/DKChainableAnimationKit.git', :tag => '2.0.0'
  pod 'Viper', :git => 'https://github.com/mownier/viper.git', :tag => '1.0'
end

target 'Umalahokan' do
  shared_pods
end

target 'UmalahokanTests' do
  inherit! :search_paths
end

target 'UmalahokanUITests' do
  inherit! :search_paths
end
