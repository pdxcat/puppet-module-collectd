# https://collectd.org/wiki/index.php/Plugin:UnixSock
class collectd::plugin::unixsock (
  $socketfile   = '/var/run/collectd-socket',
  $socketgroup  = 'collectd',
  $socketperms  = '0770',
  $deletesocket = false,
  $ensure = undef
  $interval     = undef,
) {

  include ::collectd

  validate_absolute_path($socketfile)

  collectd::plugin { 'unixsock':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/unixsock.conf.erb'),
    interval => $interval,
  }
}
