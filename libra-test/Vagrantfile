VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, path: "provision/script.sh"
  config.vm.network "private_network", ip: "1.2.3.4"
  config.vm.network "forwarded_port", guest: 8000, host: 8000, protocol: "tcp"
end
