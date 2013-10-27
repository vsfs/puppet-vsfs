class vsfs::leveldb {
  case $::operatingsystem {
    centos, Scientific: {
      $version = '1.14.0'
      $download_url = "http://leveldb.googlecode.com/files/leveldb-${version}.tar.gz"

      exec { 'download_leveldb':
        command => "/usr/bin/wget ${download_url} -O- | tar -xz",
        cwd => '/usr/local/src',
        path => ['/usr/bin', '/bin'],
      }

      exec { 'build_leveldb':
        command => 'make',
        cwd     => "/usr/local/src/leveldb-${version}",
        path    => ['/usr/bin', '/bin'],
        require => [Exec['download_leveldb'], Class['cpp', 'snappy']],
      }

      exec { 'install_leveldb':
        command => '/bin/bash -c "cp libleveldb* /usr/local/lib && cp -r include/leveldb /usr/local/include"',
        cwd => "/usr/local/src/leveldb-${version}",
        require => Exec[build_leveldb],
      }
    }
    ubuntu: {
      package { 'libleveldb-dev':
        ensure => installed,
      }
    }
  }
}
