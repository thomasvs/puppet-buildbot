define buildbot::master::config (
  $source='puppet:///modules/buildbot/master/master.cfg'
) {

  $owner    = 'buildbot'
  $group    = 'root'
  $mode     = '0644'
  $dirowner = 'buildbot'
  $dirmode  = '0755'

  $home = hiera('buildbot::home', "/home/${owner}")

  include buildbot::master::install

  include buildbot::master::base

  file { [ "${home}/master/${name}" ]:
    ensure  => directory,
    owner   => $dirowner,
    group   => $group,
    mode    => $dirmode,
  }

  exec {"buildbot::master::config::${name}-create-master":
    cwd         => "${home}/master",
    user        => $owner,
    path        => [ '/bin', '/usr/bin', ],
    command     => "buildbot create-master ${name}",
    refreshonly => false,
    unless      => "test -f ${name}/state.sqlite",
    logoutput   => on_failure,
    require     => [
      File["${home}/master"],
    ]
  }

  file { "${home}/master/${name}/master.cfg":
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    source  => $source,
    require => [
      Class['buildbot::master::install'],
    ],
    notify  => Exec["buildbot-master-config-${name}-reconfig"]
  }

  exec {"buildbot-master-config-${name}-reconfig":
    cwd         => "${home}/master",
    user        => $owner,
    path        => [ '/bin', '/usr/bin', ],
    command     => "buildbot reconfig ${name}",
    refreshonly => true,
    logoutput   => on_failure,
    require     => [
      File["${home}/master"],
    ]
  }

}
