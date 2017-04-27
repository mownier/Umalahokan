platform :ios, '9.0'
use_frameworks!
workspace 'Umalahokan'

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

def remote_data_logic_pods
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    pod 'Firebase/Storage'
end

def util_pods
    pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git', :tag => '3.1.1'
    pod 'DateTools'
end

def viper_pods
    pod 'Viper', :git => 'https://github.com/mownier/viper.git', :tag => '1.1.1'
end

target 'Umalahokan' do
    util_pods
    
    target 'UmalahokanTests' do
        inherit! :search_paths
    end
    
    target 'UmalahokanUITests' do
        inherit! :search_paths
    end
    
    target 'ServiceProvider' do
        remote_data_logic_pods
        project 'ServiceProvider/ServiceProvider'
        
        target 'ServiceProviderTests' do
            inherit! :search_paths
        end
        
        target 'UserInterface' do
            viper_pods
            project 'UserInterface/UserInterface'
            
            target 'UserInterfaceTests' do
                inherit! :search_paths
            end
            
            target 'Login' do
                project 'Login/Login'
                
                target 'LoginTests' do
                    inherit! :search_paths
                end
            end
        end
    end
end
