class xebia-nexus ( $nexus_version = "2.0.5",$temporary_directory = '/tmp',$install_dir = '/usr/share' ) {

    file{"${temporary_directory}":
      ensure => directory
    }

    class { 'xebia-nexus::download':
        nexus_version       => $nexus_version,
        temporary_directory => $temporary_directory,
        require             => File["${temporary_directory}"]
    }

    class { 'xebia-nexus::install':
        nexus_version       => $nexus_version,
        temporary_directory => $temporary_directory,
        install_dir         => $install_dir,
        require             => Class['xebia-nexus::download']
    }

    class { 'xebia-nexus::service':
        require => Class['xebia-nexus::install']
    }
}