# Install boost from source

class boost {

  $download_url = 'http://superb-dca3.dl.sourceforge.net/project/boost/boost/1.53.0/boost_1_53_0.tar.bz2'
  $cwd = '/usr/local/src/boost_1_53_0'

  if $operatingsystem == centos {
    exec { 'download_boost':
      command => "/usr/bin/wget ${download_url} -O- | tar -xj",
      cwd     => '/usr/local/src',
      require => Package['wget'],
    }

    exec { 'configure_boost':
      cwd     => $cwd,
      command => "${cwd}/bootstrap.sh -with-libraries=filesystem,serialization,system",
      require => [Exec['download_boost'], Class['cpp']]
    }

    exec { 'build_boost':
      cwd     => $cwd,
      command => "${cwd}/b2 threading=multi install",
      require => [Exec["configure_boost"], Class['cpp']]
    }
  }
 }
