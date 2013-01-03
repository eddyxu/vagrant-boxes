# Buildbot cluster

## Introduction

Build a [Buildbot](http://trac.buildbot.net) cluster through
[Vagrant](http://www.vagrantup.com).

## Slave(s)

### Prerequisites

First, run `../build_boxes.sh` if you have not done so.
Then, you should prepare 3 files under this directory.
 - `id_rsa`: the private key to access git repository.
 - `install-deps.sh`: a script to install the dependencies for building the
 project.
 - `master-config.sh`: defines the hostname, username and password of buildbot
 master node.

To start a buildbot slave:

```sh
vagrant up
```
