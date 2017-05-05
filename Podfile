platform :ios, '9.0'
use_frameworks!

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

def firebase_pods
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    pod 'Firebase/Storage'
end

target 'Umalahokan' do
    pod 'Viper', :git => 'https://github.com/mownier/viper.git', :tag => '1.1.1'
    pod 'Kingfisher'
    pod 'DateTools'
    firebase_pods
    
    target 'UmalahokanTests' do
        inherit! :search_paths
        firebase_pods
    end
    
    target 'UmalahokanUITests' do
        inherit! :search_paths
        firebase_pods
    end
end
