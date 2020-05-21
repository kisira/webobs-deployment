# webobs-deployment
An enhanced Webobs Deployment experience. Using Vagrant and Virtual Machines

Procedure For Linux(libvirt & QEMU):

Prerequisites:
1. Install libvirt, virt-manager and qemu
2. Install Vagrant
3. Install some Vagrant plugins:
    Execute the commands below to install them
    ```sh
    vagrant plugin install vagrant-libvirt
    vagrant plugin install vagrant-disksize
    ```
4. Download the latest Webobs release
    and place it in the same folder as the Vagrantfile.libvirt
5. Download the latest MATLAB releease
    and place it in the same folder as the Vagrantfile.libvirt
6. Do not remove any files already in the folder
7. Download the latest etopo.zip
    place it in the same folder as the Vagrantfile
   Optional: Pull the Ubuntu image. Execute:
        ```sh
        vagrant box add generic/ubuntu2004 --provider=virtualbox
        ```

Installation

1. Download both Webobs and MATLAB
    in the same folder as the Vagrantfile
    edit the vagrant file to reflect the version of
    Webobs and MATLAB as appropriate.
    Do this by changing the values of the WEBOBS and MATLAB variables
    These variables are on lines 30 and 32 of the Vagrantfile.libvirt
    The Vagrantfile.libvirt can be opened in any text editor
2. Run:
   ```sh
   VAGRANT_VAGRANTFILE=Vagrantfile.libvirt vagrant up>
   ```
3. Start the virtual machine from a command prompt
    Run:
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
    After the installallation completes you may logout by
    Typing:
    ```sh
    exit
    ```
5. Finally, the web server will be available locally on:
    http://localhost:9977

Procedure For Windows Or Linux:

Prerequisites:
1. Install VirtualBox
2. Install Vagrant
3. Install some Vagrant plugins:
    Execute the commands below to install them
    ```sh
    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-disksize
    ```
4. Download the latest Webobs release
    place it in the same folder as the Vagrantfile
5. Download the latest MATLAB releease
    place it in the same folder as the Vagrantfile
6. Do not remove any files already in the folder
7. Download the latest etopo.zip
    place it in the same folder as the Vagrantfile
   Optional: Pull the Ubuntu image. Execute:
        ```sh
        vagrant box add generic/ubuntu2004 --provider=virtualbox
        ```

Installation

1. Download both Webobs and MATLAB
    in the same folder as the Vagrantfile
    edit the vagrant file to reflect the version of
    Webobs and MATLAB as appropriate
    Do this by changing the values of the WEBOBS and MATLAB variables
    These variables are on lines 27 and 29 of the Vagrantfile
    The Vagrantfile file can be opened in any text editor
2. Run:
     ```sh
     vagrant up
     ```
3. Start the virtual machine from a command prompt
    Run:
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
    After the installallation completes you may logout by
    Typing:
    ```sh
    exit
    ```
5. Finally, the web server will be available locally on:
    http://localhost:9977