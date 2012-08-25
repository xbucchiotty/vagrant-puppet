    class xebia-theforeman::service{
    file{'/etc/default/foreman':
        ensure => present,
        source => 'puppet:///modules/xebia-theforeman/foreman',
        require => Class['xebia-theforeman::install'],
    }

    service{'foreman':
        ensure => running,
        require => File['/etc/default/foreman'],
    }
}