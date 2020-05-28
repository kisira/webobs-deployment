# webobs-deployment
An enhanced Webobs Deployment experience. Using Vagrant and Virtual Machines. The instructions below are for both [Linux](#procedure-for-linux-using-libvirt-and-qemu) and [Windows](#procedure-for-windows-or-linux)

## Procedure For Linux using libvirt and QEMU

### Prerequisites:
1. Install libvirt, virt-manager and qemu
2. Install Vagrant: https://www.vagrantup.com/docs/installation/
3. Install some Vagrant plugins:
    In a command shell execute the commands below to install them
    ```sh
    vagrant plugin install vagrant-libvirt
    vagrant plugin install vagrant-disksize
    ```
4. Download the latest Webobs release
    and place it in the same folder as the Vagrantfile.libvirt
5. Download the latest MATLAB release
    and place it in the same folder as the Vagrantfile.libvirt
6. Do not remove any files already in the folder
7. Download the latest etopo.zip
    place it in the same folder as the Vagrantfile
   Optional: Pull the Ubuntu image. Execute:
        ```sh
        vagrant box add generic/ubuntu2004 --provider=virtualbox
        ```

### Installation

1. Download both Webobs and MATLAB
    in the same folder as the Vagrantfile
    edit the vagrant file to reflect the version of
    Webobs and MATLAB as appropriate.
    Do this by changing the values of the WEBOBS and MATLAB variables
    Please see the Vagrantfile.libvirt for examples
    These variables are on lines 30 and 32 of the Vagrantfile.libvirt
    The Vagrantfile.libvirt can be opened in any text editor
2. Run:
   ```sh
   VAGRANT_VAGRANTFILE=Vagrantfile.libvirt vagrant up>
   ```
3. Start the virtual machine from a command prompt
    Run:
    ```sh
     vagrant up
     ```
    Then
    ```sh
    vagrant ssh
    ```
    If a password is requested type:
    ```sh
    vagrant
    ```
    This will log you in
    then install Webobs as below
4. While logged in run :
    ```sh
    sudo install.sh
    ```
    This will go through the installation process interactively
    After the installallation completes the VM will shutdown
    Restart it again with by runing:
    ```sh
    vagrant up
    ```
    You can login to the virtual machine at any time with:
    ```sh
    vagrant ssh
    ```
    While logged in you may logout at any time by executing:
    ```sh
    exit
    ```
    You can also shutdown the virtual machine by executing:
    ```sh
    vagrant halt
    ```
    And remove it completely by running:
    ```sh
    vagrant destroy -f
    ```
    Note: I have noticed that the postboard and scheduler services fail to start automatically. As a workaround I have been starting the processes manually by executing the commands below while logged in:
    ```sh
    sudo perl /etc/webobs.d/../CODE/cgi-bin/postboard.pl &
    sudo perl /etc/webobs.d/../CODE/cgi-bin/scheduler.pl &
    ```
5. Finally, the web server will be available locally on:
    http://localhost:9977

## Procedure For Windows Or Linux

### Prerequisites:
1. Install VirtualBox
2. Install Vagrant: https://www.vagrantup.com/docs/installation/
   Note: On Windows this requires installing Ruby as well
   https://www.ruby-lang.org/en/documentation/installation/#rubyinstaller
3. Install some Vagrant plugins:
    In a command shell execute the commands below to install them
    ```sh
    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-disksize
    ```
4. Download the latest Webobs release
    place it in the same folder as the Vagrantfile
5. Download the latest MATLAB release
    place it in the same folder as the Vagrantfile
6. Do not remove any files already in the folder
7. Download the latest etopo.zip
    place it in the same folder as the Vagrantfile
   Optional: Pull the Ubuntu image. Execute:
        ```sh
        vagrant box add generic/ubuntu2004 --provider=virtualbox
        ```

### Installation

1. Download both Webobs and MATLAB
    in the same folder as the Vagrantfile
    edit the vagrant file to reflect the version of
    Webobs and MATLAB as appropriate
    Do this by changing the values of the WEBOBS and MATLAB variables
    Please see the Vagrantfile for examples
    These variables are on lines 27 and 29 of the Vagrantfile
    The Vagrantfile file can be opened in any text editor
2. Run:
     ```sh
     vagrant up
     ```
3. Start the virtual machine from a command prompt
    Run:
    ```sh
     vagrant up
     ```
    Then
    ```sh
    vagrant ssh
    ```
    If a password is requested type:
    ```sh
    vagrant
    ```
    This will log you in
    then install Webobs as below
4. While logged in run :
    ```sh
    sudo install.sh
    ```
    This will go through the installation process interactively
    After the installallation completes the VM will shutdown
    Restart it again with by runing:
    ```sh
    vagrant up
    ```
    You can login to the virtual machine at any time with:
    ```sh
    vagrant ssh
    ```
    While logged in you may logout at any time by executing:
    ```sh
    exit
    ```
    You can also shutdown the virtual machine by executing:
    ```sh
    vagrant halt
    ```
    And remove it completely by running:
    ```sh
    vagrant destroy -f
    ```
    Note: I have noticed that the postboard and scheduler services fail to start automatically. As a workaround I have been starting the processes manually by executing the commands below while logged in:
    ```sh
    sudo perl /etc/webobs.d/../CODE/cgi-bin/postboard.pl &
    sudo perl /etc/webobs.d/../CODE/cgi-bin/scheduler.pl &
    ```
5. Finally, the web server will be available locally on:
    http://localhost:9977