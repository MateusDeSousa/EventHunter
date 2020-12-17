platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

workspace 'EventHunter'

pod 'lottie-ios'
pod 'AFNetworking', '~> 4.0'

target 'EventHunter' do
    project 'Modules/EventHunter/EventHunter.project'
end

target 'mCore' do
  project 'Modules/mCore/mCore.project'
end

target 'mNetwork' do
  project 'Modules/mNetwork/mNetwork.project'
  target 'mNetworkTests' do
    project 'Modules/mNetwork/mNetwork.project'
    :inherited_paths
  end
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
