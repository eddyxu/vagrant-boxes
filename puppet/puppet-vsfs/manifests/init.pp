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
    centos: { $git = 'git'
          $vim = 'vim-enhanced'
          $pkgconfig = 'pkgconfig'
          $libattr = 'libattr-devel'
          $libfuse = 'fuse-devel'
        }
    ubuntu: { $git = 'git-core'
          $vim = 'vim'
          $pkgconfig = 'pkg-config'
          $libattr = 'libattr1-dev'
          $libfuse = 'libfuse-dev'
        }
  }

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

  package { 'libattr-devel':
    ensure => installed,
    name   => $libattr,
  }

  if $operatingsystem == "centos" {
    package { ['protobuf-devel', 'mysql++-devel', 'gperftools-devel']:
      ensure  => installed,
      require => Yumrepo["EPEL"],
    }
  } else {
    package { ['libprotobuf-dev', 'libmysql++-dev', 'libgoogle-perftools-dev']:
      ensure => installed,
    }
  }
}

include 'vsfs'
