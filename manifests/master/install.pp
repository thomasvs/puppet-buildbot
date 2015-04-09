class buildbot::master::install {

  include buildbot::common::install

  case $::operatingsystem {
    /^(RedHat|CentOS|Fedora)$/: {
      $pkgs = [
        'buildbot-master',
        'python-twisted-conch',
      ]
    }
    /^(Ubuntu|Debian)$/: {
      $pkgs = [
        'buildbot',
        'python-twisted-conch',
      ]
    }
     default: {
      fail('Unsupported operating system')
    }
  }

  package { $pkgs:
    ensure => present,
  }

}
