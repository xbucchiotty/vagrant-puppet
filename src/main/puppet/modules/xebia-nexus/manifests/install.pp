class xebia-nexus::install($nexus_version,$temporary_directory,$install_dir){

    file {"${install_dir}/nexus-${nexus_version}":
        ensure => present,
        recurse => true,
        source => "${temporary_directory}/nexus-${nexus_version}",
        require =>  Class["xebia-nexus::download"]
    }

    file {"${install_dir}/nexus":
       ensure => 'link',
       target => "${install_dir}/nexus-${nexus_version}",
       require =>  File["${install_dir}/nexus-${nexus_version}"]
    }

    file {'/etc/init.d/nexus':
        ensure => present,
        content => template('xebia-nexus/nexus.erb'),
        mode => '0744',
        require => File["${install_dir}/nexus"]
    }
}