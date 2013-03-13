# Build Berkeley DB from source

class bdb {
  $version = "5.1.29"
  $url = "http://download.oracle.com/berkeley-db/db-${version}.tar.gz"
  $cwd = "/usr/local/src/db-${version}/build_unix"

  case $operatingsystem {
    centos: {
      exec { 'download':
        command => "/usr/bin/wget ${url} -O- | tar -xzf -",
        cwd     => "/usr/local/src",
        timeout => 120,
      }

      exec { 'configure':
        command => "/usr/local/src/db-5.1.29/dist/configure --enable-cxx --prefix=/usr/local",
        cwd     => $cwd,
        require => Exec['download']
      }

      exec { 'build':
        command   => "make",
        cwd       => $cwd,
        timeout   => 0,
        path      => ["/bin", "/usr/bin"],
        require   => Exec['configure']
      }

      exec { 'install':
        command => "make install",
        cwd     => $cwd,
        path    => ["/bin", "/usr/bin"],
        require => Exec['build']
      }
    }

    ubuntu: {
      package { 'libdb5.1++-dev':
        ensure => present,
      }
    }
  }
}
