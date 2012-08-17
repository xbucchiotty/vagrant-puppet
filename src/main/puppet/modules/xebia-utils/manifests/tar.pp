class xebia-utils::tar{
    define extract($working_directory,$file_name,$creates) {
        exec { "tar-extract-$name":
            command => "/bin/tar -xzf $file_name",
            creates => $creates,
            cwd => $working_directory
        }
    }
}
