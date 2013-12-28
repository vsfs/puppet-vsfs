# Install thrift with libevent
class vsfs::thrift {
  include cpp
  include libevent
  $version = '0.9.0'

  package { ['bison', 'flex']:
    ensure => installed,
  }

  exec { 'download_thrift':
    command => "wget https://archive.apache.org/dist/thrift/${version}/thrift-${version}.tar.gz -O- | tar -xz",
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
