# Install thrift with libevent
class thrift {
  include cpp
  include libevent
  $version = '0.9.0'

  exec { 'download_thrift':
    command => "wget https://dist.apache.org/repos/dist/release/thrift/${version}/thrift-${version}.tar.gz -O- | tar -xzf -",
    cwd     => '/usr/local/src',
    path    => ['/usr/bin', '/bin'],
  }

  exec { 'configure and build':
    cwd     => "/usr/local/src/thrift-${version}",
    command => '/bin/bash -c "./configure --without-python --without-java --without-ruby && make && make install"',
    timeout => 0,
    require => [Exec['download_thrift'], Class['cpp', 'libevent']]
  }
}
