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
		centos: { $git = "git"
				  $vim = "vim-enhanced"
				  $pkgconfig = "pkgconfig"
				}
		ubuntu: { $git = "git-core"
				  $vim = "vim"
				  $pkgconfig = "pkg-config"
				}
	}

	package { 'git':
		name => $git,
		ensure => present,
	}

	package { [ 'autoconf', 'automake', 'cscope', 'ctags', 'curl', 'make', 'wget',
			'libtool', 'gdb' ]:
		ensure => present,
	}

	package { 'vim':
		name => $vim,
		ensure => present,
	}

	package { 'pkgconfig':
		name => $pkgconfig,
		ensure => installed,
	}

	package { ['fuse', 'fuse-devel']:
		ensure => installed,
	}

  package { 'libattr-devel':
    ensure => installed,
  }

  package { ['protobuf-devel', 'mysql++-devel']:
    ensure => installed,
    require => Yumrepo["EPEL"],
  }
}

include 'vsfs'
