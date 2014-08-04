Vagrant.configure("2") do |config|
  config.vm.box = "goondocker-0.0.1"
  config.vm.box_url = "http://www.eduardoheredia.com.br/rep/vagrant/archlinux64.box"
  config.vm.hostname = "goondocker"

  config.vm.provision "shell", path: "provision/setup_docker.sh"
end
