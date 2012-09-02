# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :puppet do |config|
        config.vm.box="lucid32-fr"
        config.vm.host_name="puppet"
		config.vm.customize ["modifyvm", :id, "--memory", 1024]
        config.vm.network :hostonly, "192.168.56.203"
		config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "src/main/vagrant"
            puppet.manifest_file = "puppet.pp"
            puppet.module_path  = "src/main/puppet/modules"
        end
    end

	config.vm.define :foreman do |config|
        config.vm.box="squeeze"
        config.vm.host_name="foreman"
		config.vm.customize ["modifyvm", :id, "--memory", 1024]
        config.vm.network :hostonly, "192.168.56.205"
		config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "src/main/vagrant"
            puppet.manifest_file = "foreman.pp"
            puppet.module_path  = "src/main/puppet/modules"
        end
    end

    config.vm.define :node1 do |config|
        config.vm.box="lucid32-fr"
        config.vm.host_name="node1"
        config.vm.network :hostonly, "192.168.56.204"
    end

end
