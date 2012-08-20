class xebia-mysqld::service {
  service { 'mysql':
    enable => true,
    ensure => running,
    hasstatus => true,
    require => [ Class['xebia-mysqld::install'], Class['xebia-mysqld::config'] ]
  }
}
