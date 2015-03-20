define buildbot::slave::config (
  $connection='localhost:9989',
  $botname='example-slave',
  $botpass='pass'
) {

  $owner    = 'buildbot'
  $group    = 'root'
  $mode     = '0644'
  $dirowner = 'buildbot'
  $dirmode  = '0755'

  $home = hiera('buildbot::home', "/home/${owner}")

  include buildbot::slave::install

  include buildbot::slave::base

  file { "${home}/slave/${name}":
    ensure  => directory,
    owner   => $dirowner,
    group   => $group,
    mode    => $dirmode,
  }

  exec {"buildbot::slave::config::${name}-create-slave":
    cwd         => "/${home}/slave",
    user        => $owner,
    path        => [ '/bin', '/usr/bin', ],
    command     => "buildslave create-slave ${name} ${connection} ${botname} ${botpass}",
    refreshonly => false,
    unless      => "test -f ${name}/buildbot.tac",
    logoutput   => on_failure,
    require     => [
      File["${home}/slave"],
      Class['buildbot::slave::install']
    ]
  }

}
