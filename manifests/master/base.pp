class buildbot::master::base {
    $owner    = 'buildbot'
    $group    = 'root'
    $mode     = '0644'
    $dirowner = 'buildbot'
    $dirmode  = '0755'

    file { "/home/$owner/master":
        owner   => $dirowner,
        group   => $group,
        mode    => $dirmode,
        ensure  => directory,
    }

}
