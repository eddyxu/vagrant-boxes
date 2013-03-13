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
  include boost
  include bdb

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
			'libtool' ]:
		ensure => present,
	}

	package { 'vim':
		name => $vim,
		ensure => present,
	}

	package { 'pkgconfig':
		name => $pkgconfig,
		ensure => present,
	}

	package { ['fuse', 'fuse-devel']:
		ensure => present,
	}
}

include 'vsfs'
