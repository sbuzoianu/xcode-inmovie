platform :ios, '9.3'

inhibit_all_warnings!

def default_pods
	pod 'BlurryModalSegue'
end

target 'InMovies' do
	default_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = "NO"
        end
    end
end