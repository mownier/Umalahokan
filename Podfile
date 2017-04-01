platform :ios, '9.0'
use_frameworks!
workspace 'Umalahokan'

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

def remote_data_logic_pods
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    pod 'Firebase/Storage'
end

def component_pods
    pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git', :tag => '3.1.1'
    pod 'DateTools'
    pod 'Viper', :git => 'https://github.com/mownier/viper.git', :tag => '1.0'
end

abstract_target 'UmalahokanApp' do
    target 'Umalahokan' do
        target 'UmalahokanTests' do
            inherit! :search_paths
        end
        
        target 'UmalahokanUITests' do
            inherit! :search_paths
        end
    end
end

abstract_target 'UmalahokanRemoteDataLogic' do
    remote_data_logic_pods

    target 'ServiceProvider' do
        project 'ServiceProvider/ServiceProvider'
        
        target 'ServiceProviderTests' do
            inherit! :search_paths
        end
    end
end

abstract_target 'UmalahokanComponent' do
    component_pods
    
    target 'Login' do
        project 'Login/Login'
        
        target 'LoginTests' do
            inherit! :search_paths
        end
        
        target 'LoginUITests' do
            inherit! :search_paths
        end
    end
end
