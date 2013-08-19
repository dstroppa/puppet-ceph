# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Vagrant >1.1 config
  config.vm.box = "precise64"

  #config.vm.provider "virtualbox" do |vb|
    config.vm.box_url = "http://cloud-images.ubuntu.com/raring/current/raring-server-cloudimg-vagrant-amd64-disk1.box"
    #vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    #vb.customize ["modifyvm", :id, "--macaddress1", "auto"]
  #end
  #config.vm.provider "vmware_fusion" do |vf|
    #vf.box_url = "https://www.dropbox.com/s/kloqerzoetl1fyy/raring64_v2.box"
  #end

  (0..0).each do |i|
    config.vm.define "mon#{i}" do |mon|
      mon.vm.hostname = "ceph-mon#{i}.test"
      mon.vm.network :private_network, ip: "192.168.251.1#{i}"
      mon.vm.network :private_network, ip: "192.168.252.1#{i}"
      mon.vm.provision :shell, :path => "examples/mon.sh"
      #config.vm.provider "virtualbox" do |vb|
      #  vb.gui = true
      #end
    end
  end

  (0..1).each do |i|
    config.vm.define "osd#{i}" do |osd|
      osd.vm.hostname = "ceph-osd#{i}.test"
      osd.vm.network :private_network, ip: "192.168.251.10#{i}"
      osd.vm.network :private_network, ip: "192.168.252.10#{i}"
      osd.vm.provision :shell, :path => "examples/osd.sh"
      #config.vm.provider "virtualbox" do |vb|
      #  vb.gui = true
      #end
      (0..1).each do |d|
        config.vm.provider "virtualbox" do |vb|
          vb.customize [ "createhd", "--filename", "disk-#{i}-#{d}", "--size", "5000" ]
          vb.customize [ "storageattach", :id, "--storagectl", "SATA Controller", "--port", 3+d, "--device", 0, "--type", "hdd", "--medium", "disk-#{i}-#{d}.vdi" ]
        end
        config.vm.provider "vmware_fusion" do |vf|
          #osd.vm.vmx[""] =
          #osd.vm.vmx["scsi0:1.present"] = "TRUE"
          #osd.vm.vmx["scsi0:1.fileName"] = "disk-#{i}-#{d}.vmdk"
        end
      end
    end
  end

  (0..0).each do |i|
    config.vm.define "mds#{i}" do |mds|
      mds.vm.hostname = "ceph-mds#{i}.test"
      mds.vm.network :private_network, ip: "192.168.251.20#{i}"
      mds.vm.network :private_network, ip: "192.168.252.20#{i}"
      mds.vm.provision :shell, :path => "examples/mds.sh"
    end
  end
end
