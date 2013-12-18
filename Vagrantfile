

Vagrant.configure("2") do |config|
	config.vm.box = "coreos"
	config.vm.box_url = "http://storage.core-os.net/coreos/amd64-generic/dev-channel/coreos_production_vagrant.box"

	# Fix docker not being able to resolve private registry in VirtualBox
	config.vm.provider :virtualbox do |vb, override|
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	end
	config.vm.provision :shell, :inline => <<-cmds 
		docker build github.com/rwheaton/coreos-docker-lemp
	cmds
end
