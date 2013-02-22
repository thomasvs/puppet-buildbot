define buildbot::master::service () {

  buildbot::common::service { $name:
    type     => 'master',
    requires => [
      Buildbot::Master::Config[$name],
    ]
  }

}
