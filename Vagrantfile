Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/windows-server"
  config.vm.communicator = "winssh"
  config.vm.provision "shell", path: "setup.ps1"
end
