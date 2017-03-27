platform :ios, '9.0'
use_frameworks!
workspace 'Umalahokan'

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

def firebase_pods
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    pod 'Firebase/Storage'
end

def util_pods
    pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git', :tag => '3.1.1'
    pod 'DateTools'
    pod 'Viper', :git => 'https://github.com/mownier/viper.git', :tag => '1.0'
end

abstract_target 'UmalahokanApp' do
    firebase_pods
    
    target 'Umalahokan' do
        util_pods
        
        target 'UmalahokanTests' do
            inherit! :search_paths
        end
        
        target 'UmalahokanUITests' do
            inherit! :search_paths
        end
    end
    
    target 'ServiceProvider' do
        project 'ServiceProvider/ServiceProvider'
        
        target 'ServiceProviderTests'
    end
end
