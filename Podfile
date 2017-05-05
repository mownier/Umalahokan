platform :ios, '9.0'
use_frameworks!

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

target 'Umalahokan' do
    pod 'Viper', :git => 'https://github.com/mownier/viper.git', :tag => '1.1.1'
    pod 'Kingfisher'
    pod 'DateTools'
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    pod 'Firebase/Storage'
    
    target 'UmalahokanTests' do
        inherit! :search_paths
    end
    
    target 'UmalahokanUITests' do
        inherit! :search_paths
    end
end
