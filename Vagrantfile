

Vagrant.configure("2") do |config|
	config.vm.box = "coreos"
	config.vm.box_url = "http://storage.core-os.net/coreos/amd64-generic/dev-channel/coreos_production_vagrant.box"

	# Fix docker not being able to resolve private registry in VirtualBox
	config.vm.provider :virtualbox do |vb, override|
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	end
	# Define a static IP
    config.vm.network "private_network", ip: "10.10.10.10"

	config.vm.network :forwarded_port, guest: 8080, host: 8080
	config.vm.network :forwarded_port, guest: 8081, host: 8081
	config.vm.network :forwarded_port, guest: 3306, host: 3307

    #Share the current folder via NFS
   config.vm.synced_folder ".", "/home/core/sites",
           id: "core",
           :nfs => true,
           :mount_options => ['nolock,vers=3,udp,noatime']
	
    config.vm.provision "shell",
            path: "./provision-docker-lemp.sh"
end
