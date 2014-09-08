Vagrant.configure("2") do |config|
  config.vm.box = "landregistry/ubuntu"

  config.ssh.forward_agent = true
  config.vm.network "private_network", :ip => "172.16.42.43"
  config.vm.provision :shell, :path => 'script/provision-vm'

  config.vm.synced_folder ".aptget", "/var/cache/apt/archives/"

  config.vm.provider :virtualbox do |vb|
    vb.name = "landregistry-development"
    vb.customize ['modifyvm', :id, '--memory', ENV['VM_MEMORY'] || 4096]
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    vb.customize ["modifyvm", :id, "--cpus", ENV['VM_CPUS'] || 4]
  end

  vagrantfile_extra = "#{ENV['VAGRANT_CWD']}/Vagrantfile_extra.rb"
  eval File.open(vagrantfile_extra).read if File.exists?(vagrantfile_extra)
end
