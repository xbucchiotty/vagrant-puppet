class xebia-nexus::download($nexus_version,$temporary_directory){
    include xebia-utils

    xebia-utils::wgetanduntar::install{'install nexus':
        source                  => "http://www.sonatype.org/downloads/nexus-${nexus_version}-bundle.tar.gz",
        wget_timeout            => 3600,
        installation_directory  => $temporary_directory,
        temporary_file_name     => "nexus-${nexus_version}-bundle.tar.gz",
        destination             => "${temporary_directory}/nexus-${nexus_version}",
    }

}
