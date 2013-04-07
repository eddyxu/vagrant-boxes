# == Class: vsfs
#
# Install VSFS Development Environment.
#
# === Authors
#
# Lei Xu <eddyxu@gmail.com>
#
# === Copyright
#
# Copyright 2013 Lei Xu
#
class vsfs {
  include bdb
  include boost
  include cpp
  include google
  include leveldb
  include libevent
  include thrift

  case $operatingsystem {
    centos, Scientific: {
      $git = 'git'
      $vim = 'vim-enhanced'
      $pkgconfig = 'pkgconfig'
      $libattr = 'libattr-devel'
      $libfuse = 'fuse-devel'
	  $libssl = 'openssl-devel'
    }
    ubuntu: {
      $git = 'git-core'
      $vim = 'vim'
      $pkgconfig = 'pkg-config'
      $libattr = 'libattr1-dev'
      $libfuse = 'libfuse-dev'
	  $libssl = 'libssl-dev'
    }
  }

  exec { 'apt-update':
	command => "/usr/bin/apt-get update"
  }

  Exec["apt-update"] -> Package <| |>

  package { 'git':
    ensure => present,
    name => $git,
  }

  package { [ 'autoconf', 'automake', 'cscope', 'ctags', 'curl', 'make', 'wget',
      'libtool', 'gdb' ]:
    ensure => present,
  }

  package { 'vim':
    ensure => present,
    name => $vim,
  }

  package { 'pkgconfig':
    ensure => installed,
    name => $pkgconfig,
  }

  package { ['fuse', $libfuse]:
    ensure => installed,
  }

  package { 'libssl':
	ensure => installed,
	name => $libssl,
  }

  package { 'libattr-devel':
    ensure => installed,
    name   => $libattr,
  }

  case $operatingsystem {
    centos, Scientific: {
      package { ['protobuf-devel', 'mysql++-devel', 'gperftools-devel']:
        ensure  => installed,
        require => Yumrepo["EPEL"],
      }
    }
    ubuntu: {
      package { ['libprotobuf-dev', 'libmysql++-dev', 'libgoogle-perftools-dev']:
        ensure => installed,
      }
    }
  }
}

include 'vsfs'
