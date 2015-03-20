class buildbot::slave::base {

  $owner    = 'buildbot'
  $group    = 'root'
  $mode     = '0644'
  $dirowner = 'buildbot'
  $dirmode  = '0755'

  $home = hiera('buildbot::home', "/home/${owner}")

  file { "${home}/slave":
    ensure  => directory,
    owner   => $dirowner,
    group   => $group,
    mode    => $dirmode,
  }

}
