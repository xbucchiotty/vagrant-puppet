class xebia-puppetdashboard::install{

    package{'puppet-dashboard':
        ensure  => present,
        notify  => Exec['create mysql dashboard user'],
        require => [Class['xebia-puppetdashboard::prerequisites'],Xebia-utils::Aptget::Update['puppetdashboard-aptgetupdate']]
    }

    file{'/etc/puppet-dashboard/database.yml':
            ensure => present,
            source => 'puppet:///modules/xebia-puppetdashboard/database.yml',
            require => Package['puppet-dashboard']
    }

    exec{'create mysql dashboard user':
        command => "/usr/bin/mysql -e \"CREATE USER 'dashboard'@'localhost' IDENTIFIED BY 'dashboard';\"",
        require => Package['mysql-server'],
        refreshonly =>true,
        notify => Exec['create dashboard-production database'],
    }

    exec{'create dashboard-production database':
        command => "/usr/bin/mysql -e \"CREATE DATABASE dashboard_production CHARACTER SET utf8;\"",
        refreshonly =>true,
        notify => Exec['grant dashboard user'],
    }

    exec{'grant dashboard user':
        command => "/usr/bin/mysql -e \"GRANT ALL PRIVILEGES ON dashboard_production.* TO 'dashboard'@'localhost';\"",
        refreshonly =>true,
        notify => Exec['migrate dashboard-production database'],
    }

    exec{'migrate dashboard-production database':
        command =>'/usr/bin/rake RAILS_ENV=production db:migrate',
        cwd => '/usr/share/puppet-dashboard',
        require => File['/etc/puppet-dashboard/database.yml'],
        refreshonly =>true,
    }
}