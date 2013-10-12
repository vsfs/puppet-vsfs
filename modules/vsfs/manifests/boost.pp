# vim: set ft=ruby
# Install boost from source

class vsfs::boost {

  $download_url = 'http://superb-dca3.dl.sourceforge.net/project/boost/boost/1.54.0/boost_1_54_0.tar.bz2'
  $cwd = '/usr/local/src/boost_1_54_0'

  case $operatingsystem {
    centos, Scientific: {
      exec { 'download_boost':
        command => "/usr/bin/wget ${download_url} -O- | tar -xj",
        cwd     => '/usr/local/src',
        require => Package['wget'],
      }

      exec { 'configure_boost':
        cwd      => $cwd,
        command  => "/bin/bash -c '${cwd}/bootstrap.sh -with-libraries=filesystem,system'",
        require  => [Exec['download_boost'], Class['cpp']],
        provider => shell,
      }

      exec { 'build_boost':
        cwd     => $cwd,
        command => "/bin/bash -c '${cwd}/b2 threading=multi install'",
        require => Exec['configure_boost'],
        timeout => 0,
      }
    }
    ubuntu: {
      package { 'libboost-filesystem1.54-dev':
        ensure => installed,
      }
    }
  }
}
