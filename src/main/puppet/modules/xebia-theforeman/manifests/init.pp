class xebia-theforeman($temporary_directory = '/tmp') {
    class{'xebia-theforeman::prerequisites':
        temporary_directory => $temporary_directory,
        require => Class['xebia-gem']
    }
    include xebia-theforeman::install
    include xebia-theforeman::service
}

