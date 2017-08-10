# go-gu

work in progress ..

## Vagrant
Need many OS's for testing 

brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager

### Usage
Usage

Add the Vagrant box you want to use. We'll use Ubuntu 12.04 for the following example.

$ vagrant box add precise64 http://files.vagrantup.com/precise64.box
You can find more boxes at Vagrant Cloud

Now create a test directory and cd into the test directory. Then we'll initialize the vagrant machine.

$ vagrant init precise64
Now lets start the machine using the following command.

$ vagrant up
You can ssh into the machine now.

$ vagrant ssh
Halt the vagrant machine now.

$ vagrant halt
Other useful commands are suspend, destroy etc.
