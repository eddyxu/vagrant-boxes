# Install g++ 4.7 with C++11 support.
class cpp {
  if $operatingsystem == centos {
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
export PATH=/opt/centos/devtoolset-1.1/root/usr/bin/:$PATH',
      require => Package['devtoolset-1.1'],
    }
  } else {
    # Ubuntu
    package { 'g++':
      ensure => installed,
    }
  }
 }
