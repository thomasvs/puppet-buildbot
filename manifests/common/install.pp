class buildbot::common::install {
    user { 'buildbot':
        ensure => present,
        comment => 'BuildBot user',
        gid => 'buildbot',
        home => '/home/buildbot',
        require => Group['buildbot'],
        managehome => true,
    }

    group { 'buildbot':
        ensure => present,
    }
}
