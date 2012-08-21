class xebia-utils::zip{
    define extract($working_directory,$file_name,$creates) {
        exec { "unzip-$name":
            command => "/usr/bin/unzip $file_name",
            creates => $creates,
            cwd => $working_directory,
        }
    }

}
