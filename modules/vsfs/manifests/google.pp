# Install google-test, google-mock, google-gflags, google-logging.
class vsfs::google {
  include cpp

  $gflags_version = '2.0-1'

  case $operatingsystem {
    centos, Scientific: {
      package { 'gflags-devel':
        ensure   => installed,
        provider => rpm,
        source   => "https://gflags.googlecode.com/files/gflags-devel-${gflags_version}.amd64.rpm",
        require  => Package['gflags']
      }

      package { 'gflags':
        ensure   => installed,
        provider => rpm,
        source   => "https://gflags.googlecode.com/files/gflags-${gflags_version}.amd64.rpm"
      }

      package { 'glog-devel':
        ensure => installed
      }
    }
    ubuntu: {
      package { 'libgflags2':
        ensure   => installed,
        provider => apt,
        source   => "https://gflags.googlecode.com/files/libgflags0_${gflags_version}_amd64.deb"
      }

      package { 'libgflags-dev':
        ensure   => installed,
        provider => apt,
        source   => "https://gflags.googlecode.com/files/libgflags-dev_${gflags_version}_amd64.deb"
      }

      package { 'libgoogle-glog-dev':
        ensure => installed,
      }
    }
  }

  package { 'unzip':
    ensure => installed,
  }
}
