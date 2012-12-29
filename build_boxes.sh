#!/bin/bash
#
# Build the following boxes for vagrant.
#  * Ubuntu LTS (12.04)
#  * Ubuntu Latest (a.k.a Non-LTS) (12.10)
#
# Detail:
#  http://seletz.github.com/blog/2012/01/17/creating-vagrant-base-boxes-with-veewee/
#
# Copyright 2012 (c) Lei Xu <eddyxu@gmail.com>

# Usage: build_vagrant_box NAME TEMPLATE
function build_vagrant_box {
	vagrant basebox build $1
	vagrant validate $1
	vagrant basebox export --force $1
	vagrant box add --force $1 $1.box
}

build_vagrant_box 'Ubuntu.LTS'  'ubuntu-12.04.1-server-amd64'
build_vagrant_box 'Ubuntu' 'ubuntu-12.10-server-amd64'
