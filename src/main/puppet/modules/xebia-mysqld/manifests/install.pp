class xebia-mysqld::install {
  package {
    'mysql-server':
      ensure => installed
  }
}
