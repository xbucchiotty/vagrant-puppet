class xebia-theforeman::install(){

    package {'foreman-mysql':
        ensure => present,
        notify => Exec['create mysql foreman user'],
        require => [Class['xebia-theforeman::prerequisites'],Xebia-utils::Aptget::Update['foreman-aptgetupdate']]
    }

    file{'/etc/foreman/database.yml':
        ensure => present,
        source => 'puppet:///modules/xebia-theforeman/database.yml',
        require => Package['foreman-sqlite3'],
    }

    exec{'create mysql foreman user':
        command => "/usr/bin/mysql -e \"CREATE USER 'foreman'@'localhost' IDENTIFIED BY 'foreman';\"",
        require => Package['mysql-server'],
        refreshonly =>true,
        notify => Exec['create foreman database'],
    }

    exec{'create foreman database':
        command => "/usr/bin/mysql -e \"CREATE DATABASE foreman CHARACTER SET utf8;\"",
        refreshonly =>true,
        notify => Exec['grant foreman user'],
    }

    exec{'grant foreman user':
        command => "/usr/bin/mysql -e \"GRANT ALL PRIVILEGES ON foreman.* TO 'foreman'@'localhost';\"",
        refreshonly =>true,
        notify => Exec['migrate foreman database'],
    }

    exec{'migrate foreman database':
        command =>'/usr/bin/rake RAILS_ENV=production db:migrate',
        cwd => '/usr/share/foreman',
        require => File['/etc/foreman/database.yml'],
        refreshonly =>true,
    }
}