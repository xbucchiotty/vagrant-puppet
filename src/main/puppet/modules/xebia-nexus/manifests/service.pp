class xebia-nexus::service {
     service {"nexus":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        require => File['/etc/init.d/nexus']
    }
}