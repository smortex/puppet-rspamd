# rspamd::config
# ===========================
#
# @summary this type manages a single configuration file
#
# @param value
#   the value of this config entry.
#
# @param mode
#   Can be `merge` or `override`, and controls whether the config entry will be
#   written to `local.d` or `override.d` directory.
#
# @param ensure
#   whether this entry should be `present` or `absent`. Usually not needed at all,
#   because the config file will be fully managed by puppet and re-created each time.
#
# @author Bernhard Frauendienst <puppet@nospam.obeliks.de>
#
define rspamd::config (
  Hash[String, Any] $value,
  Enum['merge', 'override'] $mode   = 'merge',
  Enum['present', 'absent'] $ensure = 'present',
) {
  include rspamd

  $folder = $mode ? {
    'merge' => 'local.d',
    'override' => 'override.d',
  }
  $full_filename = $title ? {
    /\./    => $title,
    default => "${title}.conf",
  }
  $full_file = "${rspamd::config_path}/${folder}/${full_filename}"

  file { $full_file:
    ensure  => $ensure,
    content => $value.to_json_pretty,
    notify  => Service['rspamd'],
  }
}
