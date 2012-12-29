# Vagrant Boxes

This project includes a set of tools to set up and use
[Vagrant](http://vagrantup.com) Boxes.  It includes the Vagrant configuration
files for the following scenarios:
 - Kernel development (/kernel-dev)
 - Buildbot slave node

Because of the personal preference, all boxes are based on Ubuntu Server (one
LTS and one non-LTS).

## Dependancies

* [VirtualBox](https://www.virtualbox.org) (4.2+)
* [RVM](https://rvm.io)
* [Vagrant](http://vagrantup.com)
* [Veewee](https://github.com/jedi4ever/veewee)

## Install and Run

### Install dependancies

The first step is to install VirtualBox on your machine.

Then, install Ruby + RVM ([more details](http://seletz.github.com/blog/2012/01/17/creating-vagrant-base-boxes-with-veewee/)):

```sh
# Install rvm
$ curl -L https://get.rvm.io | bash -s stable --ruby
$ rvm use 1.9.3
$ rvm gemset create veewee
$ rvm 1.9.3@veewee
```

Note that for such installation procedures, you need to run `rvm 1.9.3@veewee`
before use Vagrant.

### Build the base box.

Instead of downloading the vagrant box, it offers a script to build two base
boxes (Ubuntu Latest (12.10) and Ubuntu LTS (12.04)). To build these two base
boxes:

```sh
$ cd /path/of/vagrant-boxes
$ ./build_boxes.sh
```

This VM image creation process will take a while. But after its completion, two
vagrant boxes are created successfully and it is ready to go.

### Run a particular box.

For example, if you would like to start developing Linux kernel, you can follow
the following steps.

```sh
$ cd /path/of/vagrant-boxes/kernel-dev/
# It will copy your SSH private key into the VM, so you need to first put a
# validate private key to this directory first.
$ cp ~/.ssh/id_rsa .
$ vagrant up
$ vagrant ssh
```

You can run `vagrant help` for more details about how to use it.

## References

1. Vagrant Document: http://vagrantup.com/v1/docs/index.html
2. Creating Vagrant Base Boxes With Veewee:
   http://seletz.github.com/blog/2012/01/17/creating-vagrant-base-boxes-with-veewee/

## Author

Lei Xu <eddyxu@gmail.com>
