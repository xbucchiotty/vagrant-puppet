class xebia-puppetdashboard($temporary_directory) {
    include xebia-utils

    xebia-utils::aptget::update{'puppetdashboard-aptgetupdate':
    }

    class {'xebia-puppetdashboard::prerequisites':
        temporary_directory => $temporary_directory,
        notify => Xebia-utils::Aptget::Update['puppetdashboard-aptgetupdate'],
    }
    
    class{'xebia-puppetdashboard::install':
        require =>[Xebia-utils::Aptget::Update['puppetdashboard-aptgetupdate'],Class['xebia-puppetdashboard::prerequisites']],
    }

    include xebia-puppetdashboard::service
}

