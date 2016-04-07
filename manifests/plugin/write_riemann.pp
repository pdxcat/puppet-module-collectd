# https://collectd.org/wiki/index.php/Plugin:Write_Riemann
class collectd::plugin::write_riemann (
  $ensure = undef
  $manage_package   = undef,
  $riemann_host     = 'localhost',
  $riemann_port     = 5555,
  $protocol         = 'UDP',
  $store_rates      = false,
  $always_append_ds = false,
  $interval         = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_bool($store_rates)
  validate_bool($always_append_ds)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-write_riemann':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'write_riemann':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/write_riemann.conf.erb'),
    interval => $interval,
  }
}
