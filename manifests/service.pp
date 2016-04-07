class rea::service (
  $service_name   = $::rea::params::httpd_svc,
  $service_enable = true,
  $service_ensure = 'running',
  $service_manage = true,
  $service_restart = undef
) {
  # The base class must be included first because parameter defaults depend on it
  if ! defined(Class['rea::params']) {
    fail('You must include the rea::params class before using any rea defined resources')
  }

  case $service_ensure {
    true, false, 'running', 'stopped': {
      $_service_ensure = $service_ensure
    }
    default: {
      $_service_ensure = undef
    }
  }
  if $service_manage {
    service { "$service_name":
      ensure  => $_service_ensure,
      name    => $service_name,
      enable  => $service_enable,
      restart => $service_restart
    }
  }
}
