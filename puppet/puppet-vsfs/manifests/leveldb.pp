class leveldb {
  case $operatingsystem {
   centos, Scientific: {
    $repo_url = "http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"

    yumrepo { 'EPEL':
      baseurl  => "http://dl.fedoraproject.org/pub/epel/6/x86_64",
      enabled  => 1,
      gpgcheck => 0,
    }

    package { ["leveldb-devel", "snappy-devel"]:
      ensure  => installed,
      require => Yumrepo["EPEL"],
    }
  }
  ubuntu: {
    package { [ "libleveldb-dev", "libsnappy-dev" ]:
      ensure  => installed,
    }
  }
  }
}
