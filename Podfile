platform :ios, '12.0'
inhibit_all_warnings!

workspace 'EventHunter'

target 'EventHunter' do
    project 'Modules/EventHunter/EventHunter.project'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end