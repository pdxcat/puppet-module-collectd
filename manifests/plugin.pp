#
define collectd::plugin (
  $ensure  = 'present',
  $content = undef,
  $order   = '10',
  $plugin  = $name
) {

  include collectd::params
  $conf_dir = $collectd::params::plugin_conf_dir

  file { "${plugin}.load":
    ensure  => $ensure,
    path    => "${conf_dir}/${order}-${plugin}.conf",
    mode    => '0640',
    content => "# Generated by Puppet\nLoadPlugin ${plugin}\n\n${content}",
    notify  => Service['collectd'],
  }

  # Older versions of this module didn't use the "00-" prefix.
  # Delete those potentially left over files just to be sure.
  file { "older_${plugin}.load":
    ensure  => absent,
    path    => "${conf_dir}/${plugin}.conf",
    notify  => Service['collectd'],
  }

  # Older versions of this module use the "00-" prefix by default.
  # Delete those potentially left over files just to be sure.
  if $order != '00' {
    file { "old_${plugin}.load":
      ensure  => absent,
      path    => "${conf_dir}/00-${plugin}.conf",
      notify  => Service['collectd'],
    }
  }
}
