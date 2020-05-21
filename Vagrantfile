# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Proper installation
# wget -c https://releases.hashicorp.com/vagrant/2.0.3/vagrant_2.0.3_x86_64.deb
# sudo dpkg -i vagrant_2.0.3_x86_64.deb
# Then
# vagrant plugin install vagrant-vbguest
# And
# vagrant plugin install vagrant-disksize
# Matlab:
# https://www.mathworks.com/products/compiler/matlab-runtime.html

# Box / OS
VAGRANT_BOX = 'generic/ubuntu2004'

# Memorable name for your
VM_NAME = 'Webobs'

# VM User — 'vagrant' by default
VM_USER = 'vagrant'

# Where to sync to on Guest — 'vagrant' is the default user name
GUEST_PATH = '/home/' + VM_USER + '/'

WEBOBS = "WebObs-2.1.5a"

MATLAB = "MATLAB_Runtime_R2020a_glnxa64"

#IP_ADDR = "192.168.100.250"

# # VM Port — uncomment this to use NAT instead of DHCP
VM_PORT = 9977

Vagrant.configure(2) do |config|

  config.vm.boot_timeout = 3600
  # Vagrant box from Hashicorp
  config.vm.box = VAGRANT_BOX
  config.disksize.size = '32GB'

  # Actual machine name
  config.vm.hostname = VM_NAME
  config.vm.provision :shell, :inline => "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"

  config.vm.box_check_update = true

  # Set VM name in Virtualbox
  config.vm.provider "virtualbox" do |v|
    #v.gui = true
    v.name = VM_NAME
    #v.memory = 4096
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--memory", "4096"]
    v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # Set the number of virtual CPUs for the virtual machine
    v.customize ["modifyvm", :id, "--cpus", 2]
    # Enabling the I/O APIC is required for 64-bit guest operating systems, especially Windows Vista;
    # it is also required if you want to use more than one virtual CPU in a VM.
    # Advanced Programmable Interrupt Controllers (APICs) are a newer x86 hardware feature
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    # Enable the use of hardware virtualization extensions (Intel VT-x or AMD-V) in the processor of your host system
    v.customize ["modifyvm", :id, "--hwvirtex", "on"]
    # Default host uses a USB mouse instead of PS2
    #v.customize ["modifyvm", :id, "--mouse", "usb"]
    # Enable audio support for the VM & specify the audio controller
    #v.customize ["modifyvm", :id, "--audio", "dsound", "--audiocontroller", "ac97"]
    # Enable the VM's virtual USB controller & enable the virtual USB 2.0 controller
    #v.customize ["modifyvm", :id, "--usb", "on", "--usbehci", "on"]
    # Add IDE controller to the VM, to allow virtual media to be attached to the controller
    #v.customize ["storagectl", :id, "--name", "IDE Controller", "--add", "ide"]
    # Give the VM access to the host's CD/DVD drive, by attaching the medium to the virtual IDE controller
    #v.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port 0", "--device 0", "--type", "dvddrive"]
    # Enable, if Guest Additions are installed, whether hardware 3D acceleration should be available
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end

  #File provisioner
  config.vm.provision "file", source: WEBOBS + ".tar.gz", destination: GUEST_PATH + WEBOBS + ".tar.gz"
  config.vm.provision "file", source: MATLAB + ".zip", destination: GUEST_PATH + MATLAB + ".zip"
  config.vm.provision "file", source: "etopo.zip", destination: GUEST_PATH + "etopo.zip"

  #DHCP — uncomment this if not planning on using NAT
  #config.vm.network "private_network", type: "dhcp"

  # Port forwarding — comment this if planning to use DHCP instead of NAT
  config.vm.network :forwarded_port, guest: 80,   host: VM_PORT,    id: "web",    auto_correct: false
  config.vm.network :forwarded_port, guest: 3389, host: 3299,       id: "rdp",    auto_correct: false
  config.vm.network :forwarded_port, guest: 5985, host: 5985,       id: "winrm", auto_correct: false
  config.vm.network :forwarded_port, guest: 443,  host: 9444,       id: "ssl",    auto_correct: false

  config.winrm.guest_port = 5985
  config.winrm.host = "localhost"

  # Disable default Vagrant folder, use a unique path per project
  #config.vm.synced_folder '.', '/home/'+VM_USER+'', disabled: true

  #File provisioner
  config.vm.provision "file", source: "smb.conf", destination: GUEST_PATH + "smb.conf"
  config.vm.provision "file", source: "etclocalegen.txt", destination: GUEST_PATH + "etclocalegen.txt"
  config.vm.provision "file", source: "ImageMagick-6.policy.xml", destination: GUEST_PATH + "ImageMagick-6.policy.xml"
  config.vm.provision "file", source: "WEBOBS.rc", destination: GUEST_PATH + "WEBOBS.rc"
  config.vm.provision "file", source: "install.sh", destination: GUEST_PATH + "install.sh"

  LD_LIBRARY_PATH="LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/MATLAB/MATLAB_Runtime/v98/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v98/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v98/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v98/extern/bin/glnxa64"

  WEBOBS_ENV="WEBOBS=#{WEBOBS}"
  GUEST_PATH_ENV="GUEST_PATH=#{GUEST_PATH}"

  # Install Git, webobs dependencies
  config.vm.provision "shell", inline: <<-SHELL

    #systemctl disable hv-kvp-daemon.service
    DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" dist-upgrade -y

    add-apt-repository main
  	add-apt-repository universe
  	add-apt-repository restricted
  	add-apt-repository multiverse
    DEBIAN_FRONTEND=noninteractive apt-get update -y
    DEBIAN_FRONTEND=noninteractive apt-get install -y sed
    sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential
    DEBIAN_FRONTEND=noninteractive apt-get install -y git, unzip
    DEBIAN_FRONTEND=noninteractive apt-get install -y samba smbclient cifs-utils
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 apache2-utils sqlite3 imagemagick
    DEBIAN_FRONTEND=noninteractive apt-get install -y mutt xvfb curl gawk graphviz net-tools
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl gawk graphviz net-tools libdatetime-perl
    DEBIAN_FRONTEND=noninteractive apt-get install -y libdate-calc-perl libcgi-session-perl
    DEBIAN_FRONTEND=noninteractive apt-get install -y libdbd-sqlite3-perl libgraphviz-perl
    DEBIAN_FRONTEND=noninteractive apt-get install -y libimage-info-perl libtext-multimarkdown-perl
    DEBIAN_FRONTEND=noninteractive apt-get install -y libswitch-perl libintl-perl gdebi-core
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 cron anacron acl python perl
    DEBIAN_FRONTEND=noninteractive apt-get install -y libintl-perl libncurses5 locales libasound2
    DEBIAN_FRONTEND=noninteractive apt-get install -y libasound2-data ghostscript libdbi-perl wget
    DEBIAN_FRONTEND=noninteractive apt-get install -y zip default-jdk
    DEBIAN_FRONTEND=noninteractive apt-get install -y tasksel
    DEBIAN_FRONTEND=noninteractive apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils
    DEBIAN_FRONTEND=noninteractive apt-get install -y virtualbox-guest-x11

    DEBIAN_FRONTEND=noninteractive apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y

    chgrp sambashare /home/vagrant/webobs

    useradd -M -d /home/vagrant -G sambashare vagrant

    chown vagrant:sambashare /home/vagrant/webobs

    (echo "vagrant"; echo "vagrant") | smbpasswd -s -a vagrant

    smbpasswd -e vagrant

    mv #{GUEST_PATH}smb.conf /etc/samba/smb.conf

    systemctl restart smbd

    systemctl restart nmbd

    adduser vagrant vboxsf

    systemctl enable apache2

    echo #{LD_LIBRARY_PATH} >> /etc/environment
    echo #{WEBOBS_ENV} >> /etc/environment
    echo #{GUEST_PATH_ENV} >> /etc/environment
    echo "vboxsf" >> /etc/modules

    mkdir -p /usr/share/man/man1
    mkdir -p /opt/webobs

    mv #{GUEST_PATH}etclocalegen.txt /etc/locale.gen
    mv #{GUEST_PATH}ImageMagick-6.policy.xml \
                  /etc/ImageMagick-6/policy.xml
    mv #{GUEST_PATH}#{MATLAB}.zip /opt/webobs/#{MATLAB}.zip
    mv #{GUEST_PATH}#{WEBOBS}.tar.gz /opt/webobs/#{WEBOBS}.tar.gz
    locale-gen fr_FR en_US
    a2enmod cgid
    unzip /opt/webobs/#{MATLAB}.zip -d /opt/webobs
    /opt/webobs/install -mode silent -agreeToLicense yes
    tar xf /opt/webobs/#{WEBOBS}.tar.gz -C /opt/webobs/

    mv #{GUEST_PATH}install.sh /usr/local/bin/install.sh
    chmod 777 /usr/local/bin/install.sh
    ln -s /usr/local/bin/install.sh /
    #sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config

    echo "Finished setting up the webobs environment - run 'vagrant ssh' to connect,"
    echo "then 'sudo install.sh' to install Webobs"
    shutdown -h now
  SHELL

end
