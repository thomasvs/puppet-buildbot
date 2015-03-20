class buildbot::master::install {

  include buildbot::common::install

  case $::operatingsystem {
    /^(RedHat|CentOS|Fedora)$/: {
      $pkgs = [
        'buildbot-master',
      ]
    }
    /^(Ubuntu|Debian)$/: {
      $pkgs = [
        'buildbot',
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
