define buildbot::slave (
  $connection="localhost:9989",
  $botname="example-slave",
  $botpass="pass"
) {
  buildbot::slave::config { $name:
    connection => $connection,
    botname => $botname,
    botpass => $botpass}
    buildbot::slave::service {$name: }
}
