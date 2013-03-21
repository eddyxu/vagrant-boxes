# Install g++ 4.7 with C++11 support.
class cpp {
  case $operatingsystem {
	centos, Scientific: {
      yumrepo { 'devtools':
        baseurl  => 'http://people.centos.org/tru/devtools-1.1/6/x86_64/RPMS/',
		descr    => 'Redhat Dev tools.',
		enabled  => 1,
		gpgcheck => 0,
	  }
	  package { 'devtoolset-1.1':
		ensure  => installed,
		require => Yumrepo['devtools'],
	  }

	  file { '/etc/profile.d/cpp.sh':
		ensure  => present,
		content => 'export CXX=/opt/centos/devtoolset-1.1/root/usr/bin/g++
export CC=/opt/centos/devtoolset-1.1/root/usr/bin/gcc
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PATH=/opt/centos/devtoolset-1.1/root/usr/bin/:$PATH',
		require => Package['devtoolset-1.1'],
	  }
	}
	ubuntu: {
	  package { 'g++':
        ensure => installed,
	  }
	}
  }
}
