define buildbot::slave::service () {

  buildbot::common::service { $name:
    type     => 'slave',
    requires => [
      Buildbot::Slave::Config[$name],
    ]
  }

}
