class libevent {
  include cpp

  if $operatingsystem == centos {
    $version = "2.0.21-stable"
    $url = "https://github.com/downloads/libevent/libevent/libevent-${version}.tar.gz"
    $cwd = "/usr/local/src/libevent-${version}"

    exec { 'download_libevent':
      command => "wget $url -O- | tar -xzf -",
      cwd     => "/usr/local/src",
      path    => ['/usr/bin', '/bin'],
    }

    exec { 'configure_libevent':
      command => '/bin/bash -c "./configure"',
      cwd     => $cwd,
      require => [Exec['download_libevent'], Class['cpp']]
    }

    exec { 'build_install':
      command => 'make && make install',
      path    => ['/usr/bin', '/bin'],
      cwd     => $cwd,
      require => Exec['configure_libevent']
    }
  } else {
    package { 'libevent-dev':
      ensure => installed,
    }
  }
}
