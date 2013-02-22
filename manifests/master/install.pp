class buildbot::master::install {

  include buildbot::common::install

  package {[
    'buildbot-master',
  ]:
    ensure => present,
  }

}
