class xebia-puppetdashboard::prerequisites($temporary_directory = '/tmp'){
    include xebia-utils

    xebia-utils::wget::fetch{'wget apt.puppetlabs.com/pubkey.org':
        source      => 'http://apt.puppetlabs.com/pubkey.gpg',
        destination => "${temporary_directory}/pubkey.gpg",
        timeout     => 90,
        notify => Exec['import apt.puppetlabs.com/pubkey.org'],
    }

    exec{'import apt.puppetlabs.com/pubkey.org':
        command => "/usr/bin/gpg --import ${temporary_directory}/pubkey.gpg",
        refreshonly =>true,
        notify => Exec['apt-key apt.puppetlabs.com/pubkey.org'],
    }

    exec{'apt-key apt.puppetlabs.com/pubkey.org':
        command => '/usr/bin/gpg -a --export 4BD6EC30 | /usr/bin/apt-key add -',
        require => Exec['import apt.puppetlabs.com/pubkey.org'],
        notify => Xebia-utils::Aptget::Update['puppetdashboard-aptgetupdate'],
        refreshonly => true,
    }

    file{'/etc/apt/sources.list.d/puppet.list':
        ensure =>present,
        content => 'deb http://apt.puppetlabs.com/ lucid main',
        require => Exec['apt-key apt.puppetlabs.com/pubkey.org'],
        notify => Xebia-utils::Aptget::Update['puppetdashboard-aptgetupdate'],
    }

}