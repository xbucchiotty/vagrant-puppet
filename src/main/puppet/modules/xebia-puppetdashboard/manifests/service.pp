class xebia-puppetdashboard::service{

    file{'/etc/default/puppet-dashboard':
        ensure => present,
        source => 'puppet:///modules/xebia-puppetdashboard/puppet-dashboard',
        require => Class['xebia-puppetdashboard::install']
    }

    service{'puppet-dashboard':
        ensure => running,
        require => File['/etc/default/puppet-dashboard'],
    }
}