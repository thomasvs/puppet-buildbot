class buildbot::slave::base {
  $owner    = 'buildbot'
  $group    = 'root'
  $mode     = '0644'
  $dirowner = 'buildbot'
  $dirmode  = '0755'

  file { "/home/$owner/slave":
    owner   => $dirowner,
    group   => $group,
    mode    => $dirmode,
    ensure  => directory,
  }

}
