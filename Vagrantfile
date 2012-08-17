# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :puppet do |config|
        config.vm.box="lucid32-fr"
        config.vm.host_name="puppet"
	config.vm.customize ["modifyvm", :id, "--memory", 1024]
        config.vm.network :hostonly, "192.168.56.203"
    end

    config.vm.define :node1 do |config|
        config.vm.box="lucid32-fr"
        config.vm.host_name="node1"
        config.vm.network :hostonly, "192.168.56.204"
    end

end
