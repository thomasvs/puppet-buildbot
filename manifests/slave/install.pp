class buildbot::slave::install {

  include buildbot::common::install

  package {[
    'buildbot-slave',
  ]:
    ensure => present,
  }
}
