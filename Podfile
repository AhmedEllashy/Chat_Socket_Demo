# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'Chat_Socket_Practice' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Chat_Socket_Practice
pod 'Socket.IO-Client-Swift', '~> 15.2.0'
pod 'RxSwift', '~> 6.7'
pod 'RxCocoa', '~> 6.7'

end
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end