class xebia-utils::wgetandunzip{
    define install($source,$wget_timeout,$installation_directory,$temporary_file_name,$destination){
        xebia-utils::wget::fetch{"fetch $temporary_file_name":
            source => $source,
            destination => "${installation_directory}/${temporary_file_name}",
            timeout => $wget_timeout,
        }

        xebia-utils::zip::extract{"extract $temporary_file_name":
            working_directory => $installation_directory,
            file_name => $temporary_file_name,
            creates => $destination,
            require => Xebia-utils::Wget::Fetch["fetch $temporary_file_name"],
        }
    }
}