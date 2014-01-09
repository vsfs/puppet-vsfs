# Install OpenJDK 1.7 and Maven
class vsfs::java {
  case $::operatingsystem {
    centos, Scientific: {
      package { 'openjdk':
        name   => "java-1.7.0-openjdk",
        ensure => latest,
      }
    }
    ubuntu, Debian: {
      package { 'openjdk':
        name   => "openjdk-7-jdk",
        ensure => latest,
      }
    }
  }

  # TODO: Install maven
}
