# https://collectd.org/wiki/index.php/Plugin:Disk
class collectd::plugin::disk (
  $disks          = [],
  $ensure         = 'present',
  $ignoreselected = false,
  $interval       = undef,
  $manage_package = undef,
  $package_name   = 'collectd-disk',
  $udevnameattr   = undef,
) {

  include ::collectd

  validate_array($disks)
  validate_bool($ignoreselected)

  if $::osfamily == 'RedHat' {
    if $manage_package {
      $_manage_package = $manage_package
    }

    if $_manage_package {
      package { 'collectd-disk':
        ensure => $ensure,
        name   => $package_name,
      }
    }
  }

  collectd::plugin { 'disk':
    ensure   => $ensure,
    content  => template('collectd/plugin/disk.conf.erb'),
    interval => $interval,
  }
}
