# == Class: vsfs
#
# Install VSFS Development Environment.
#
# === Authors
#
# Lei Xu <eddyxu@gmail.com>
#
# === Copyright
#
# Copyright 2013 Lei Xu
#
class vsfs {
  include boost
  include cpp
  include google
  include libevent
  include thrift

  case $operatingsystem {
    centos, Scientific: {
      $git = 'git'
      $vim = 'vim-enhanced'
      $pkgconfig = 'pkgconfig'
      $libattr = 'libattr-devel'
      $libfuse = 'fuse-devel'
      $libssl = 'openssl-devel'

      $repo_url = 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'

      yumrepo { 'EPEL':
        baseurl  => 'http://dl.fedoraproject.org/pub/epel/6/x86_64',
        enabled  => 1,
        gpgcheck => 0,
      }
    }
    ubuntu: {
      $git = 'git-core'
      $vim = 'vim'
      $pkgconfig = 'pkg-config'
      $libattr = 'libattr1-dev'
      $libfuse = 'libfuse-dev'
      $libssl = 'libssl-dev'

      exec { 'apt-get update':
        command => '/usr/bin/apt-get update'
      }

      Exec['apt-get update'] -> Package <| |>
    }
  }

  package { 'git':
    ensure => present,
    name   => $git,
  }

  package { [ 'autoconf', 'automake', 'cscope', 'ctags', 'curl', 'make', 'wget',
      'libtool', 'gdb', 'autoconf-archive' ]:
    ensure => present,
  }

  package { 'vim':
    ensure => present,
    name   => $vim,
  }

  package { 'pkgconfig':
    ensure => installed,
    name   => $pkgconfig,
  }

  package { ['fuse', $libfuse]:
    ensure => installed,
  }

  package { 'libattr-devel':
    ensure => installed,
    name   => $libattr,
  }

  package { 'libssl':
    ensure => installed,
    name   => $libssl,
  }

  case $operatingsystem {
    centos, Scientific: {
      package { ['gperftools-devel']:
        ensure  => installed,
        require => Yumrepo['EPEL'],
      }
    }
    ubuntu: {
      package { ['libgoogle-perftools-dev']:
        ensure => installed,
      }
    }
  }
}

include 'vsfs'
