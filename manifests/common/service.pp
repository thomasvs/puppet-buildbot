define buildbot::common::service ($type, $requires=[]) {

  $user = 'buildbot'
  $home = hiera('buildbot::home', "/home/${user}")

  case $type {
    'master': { $command = 'buildbot' }
    'slave':  { $command = 'buildslave' }
    default:  { fail("Unrecognized type ${type} for buildbot") }
  }

  exec {"buildbot::${type}::service-${name}":
    cwd         => "${home}/${type}",
    user        => $user,
    path        => [ '/bin', '/usr/bin', ],
    command     => "${command} start ${name}",
    refreshonly => false,
    unless      => "test -f ${name}/twistd.pid",
    logoutput   => on_failure,
    require     => $requires
  }

  # install a cron file to start service on reboot
  file {"/etc/cron.d/buildbot-${type}-service-${name}":
    content => "# created by puppet
    @reboot ${user} cd ${home}/${type}; ${command} start ${name}
    "
  }

}
