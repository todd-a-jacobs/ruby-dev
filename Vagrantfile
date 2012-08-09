# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = 'ruby-dev'
  config.vm.box_url = 'debian-6.0.5-i386.box'
  config.vm.boot_mode = :gui
  config.vm.customize ['modifyvm', :id, '--memory', 1024]
  config.vm.host_name = 'vagrant'
  config.vm.provision :puppet, :module_path => 'modules' do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = "#{config.vm.box}.pp"
  end
  config.vm.share_folder "files",
    "/media/#{config.vm.box}/files",
    "#{ENV['HOME']}/Documents/Vagrant_Box_Shares/#{config.vm.box}/files",
    :create => true
end
