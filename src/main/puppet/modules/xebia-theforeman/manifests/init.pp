class xebia-theforeman($temporary_directory = '/tmp') {

	xebia-utils::aptget::update{'foreman-aptgetupdate':
    }

    class{'xebia-theforeman::prerequisites':
        temporary_directory => $temporary_directory,
        notify => Xebia-utils::Aptget::Update['foreman-aptgetupdate'],
    }
    class {'xebia-theforeman::install':
		require => Class['xebia-theforeman::prerequisites'],
	}
	
    include xebia-theforeman::service
}

