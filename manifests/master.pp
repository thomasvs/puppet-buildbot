define buildbot::master ($config=undef) {
    include buildbot::master::install

    buildbot::master::config {$name: source => $config}
    buildbot::master::service {$name: }
}

