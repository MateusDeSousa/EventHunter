platform :ios, '12.0'
inhibit_all_warnings!
use_frameworks!

workspace 'EventHunter'

pod 'AFNetworking', '~> 4.0'

target 'EventHunter' do
    project 'Modules/EventHunter/EventHunter.project'
    pod 'RxSwift', '6.0.0-rc.2'
    pod 'RxCocoa', '6.0.0-rc.2'
end

target 'mCore' do
  project 'Modules/mCore/mCore.project'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
