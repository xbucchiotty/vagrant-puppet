class xebia-theforeman::prerequisites($temporary_directory = '/tmp'){

    include xebia-utils

    xebia-utils::aptget::update{'theforeman-aptgetupdate':}

    file{'/etc/apt/sources.list.d/foreman.list':
        ensure =>   present,
        content => 'deb http://deb.theforeman.org/ stable main',
        notify =>   Xebia-utils::Wget::Fetch['wget deb.theforeman.org/foreman.asc']
    }

    xebia-utils::wget::fetch{'wget deb.theforeman.org/foreman.asc':
            source      => 'http://deb.theforeman.org/foreman.asc',
            destination => "${temporary_directory}/foreman.asc",
            timeout     => 90,
            notify => Exec['import apt.puppetlabs.com/pubkey.org'],
    }

    exec { 'add foreman.asc':
        command => '/usr/bin/apt-key add foreman.asc',
        cwd => "${temporary_directory}",
        notify => Xebia-utils::Aptget::Update['theforeman-aptgetupdate'],
    }

}