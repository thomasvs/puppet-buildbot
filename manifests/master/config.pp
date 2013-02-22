define buildbot::master::config (
    $source="puppet:///modules/buildbot/master/master.cfg"
) {
    $owner    = 'buildbot'
    $group    = 'root'
    $mode     = '0644'
    $dirowner = 'buildbot'
    $dirmode  = '0755'

    include buildbot::master::install

    include buildbot::master::base
    file { [ "/home/$owner/master/$name" ]:
        owner   => $dirowner,
        group   => $group,
        mode    => $dirmode,
        ensure  => directory,
    }

    exec {"buildbot::master::config::${name}-create-master":
        cwd         => "/home/$owner/master",
        user        => "$owner",
        path        => [ "/bin", "/usr/bin", ],
        command     => "buildbot create-master $name",
        refreshonly => false,
        unless      => "test -f $name/state.sqlite",
        logoutput   => on_failure,
        require     => [
            File["/home/$owner/master"],
        ]
    }

    file { "/home/$owner/master/$name/master.cfg":
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        ensure  => file,
        source => $source,
        require => [
            Class['buildbot::master::install'],
        ],
        notify => Exec["buildbot-master-config-${name}-reconfig"]
    }

    exec {"buildbot-master-config-${name}-reconfig":
        cwd         => "/home/$owner/master",
        user        => "$owner",
        path        => [ "/bin", "/usr/bin", ],
        command     => "buildbot reconfig $name",
        refreshonly => true,
        logoutput   => on_failure,
        require     => [
            File["/home/$owner/master"],
        ]
    }


}
