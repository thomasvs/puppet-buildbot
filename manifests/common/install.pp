class buildbot::common::install {

  $home = hiera('buildbot::home', '/home/buildbot')

  user { 'buildbot':
    ensure     => present,
    comment    => 'BuildBot user',
    gid        => 'buildbot',
    home       => $home,
    require    => Group['buildbot'],
    managehome => true,
  }

  group { 'buildbot':
    ensure => present,
  }

}
