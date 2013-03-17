# Install google-test, google-mock, google-gflags, google-logging.
class google {
  include cpp

  $gflags_version = '2.0-1'

  if $operatingsystem == centos {
    package { 'gflags-devel':
      provider => rpm,
      ensure   => installed,
      source   => "https://gflags.googlecode.com/files/gflags-devel-${gflags_version}.amd64.rpm",
      require  => Package['gflags']
    }

    package { 'gflags':
      provider => rpm,
      ensure   => installed,
      source   => "https://gflags.googlecode.com/files/gflags-${gflags_version}.amd64.rpm"
    }
  } else {  # Ubuntu
    package { "libgflags2",
      provider => apt,
      ensure   => installed,
      source   => "https://gflags.googlecode.com/files/libgflags0_${gflags_version}_amd64.deb"
    }

    package { 'libgflags-dev':
      provider => apt,
      ensure   => installed,
      source   => "https://gflags.googlecode.com/files/libgflags-dev_${gflags_version}_amd64.deb"
    }
  }

  package { 'unzip':
    ensure => installed,
  }

  package { 'cmake':
    ensure => installed,
  }

  # gtest
  exec { 'download_gmock':
    command   => "/usr/bin/wget http://googlemock.googlecode.com/files/gmock-1.6.0.zip -O gmock-1.6.0.zip",
    cwd       => "/usr/local/src",
  }

  exec { 'unzip_gmock':
    command => "/usr/bin/unzip -o gmock-1.6.0.zip",
    cwd     => "/usr/local/src",
    require => [Exec['download_gmock'], Package['unzip']],
  }

  exec { 'build_gmock':
    command => "/usr/bin/cmake . && /usr/bin/make",
    cwd     => "/usr/local/src/gmock-1.6.0",
    require => [Exec['unzip_gmock'], Class['cpp'], Package['cmake']],
  }

  $content = "export CXXFLAGS='-I/usr/local/src/gmock-1.6.0/include -I/usr/local/src/gmock-1.6.0/gtest/include'
export LDFLAGS='-L/usr/local/src/gmock-1.6.0/gtest -L/usr/local/src/gmock-1.6.0'"

  file { '/etc/profile.d/gtest.sh':
    ensure  => present,
    require => Exec['build_gmock'],
    content => $content,
  }

  # glog
  exec { 'download_glog':
    command   => "/usr/bin/wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz -O- | tar -xzf -",
    cwd       => "/usr/local/src",
  }

  exec { 'configure_glog':
    command => "/bin/bash -c ./configure",
    cwd  => "/usr/local/src/glog-0.3.3",
    require => Exec['download_glog'],
  }

  exec { 'build_glog':
    command => "make && make install",
    cwd     => "/usr/local/src/glog-0.3.3",
    path    => ['/usr/bin', '/bin'],
    require => Exec['configure_glog'],
  }
}
