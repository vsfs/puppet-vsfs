class vsfs::snappy {
  case $::operatingsystem {
    centos, Scientific: {
      $version = '1.1.0'
      $download_url = "http://snappy.googlecode.com/files/snappy-${version}.tar.gz"

      exec { 'download_snappy':
        command => "/usr/bin/wget ${download_url} -O- | tar -xz",
        cwd     => '/usr/local/src',
        path    => ['/usr/bin', '/bin'],
      }

      exec { 'build_snappy':
        command => '/bin/bash -c "./configure && make && make install"',
        cwd     => "/usr/local/src/snappy-${version}",
        require => [Exec['download_snappy'], Class['cpp']],
      }
    }
    ubuntu: {
      package { 'libsnappy-dev':
        ensure => installed,
      }
    }
  }
}
