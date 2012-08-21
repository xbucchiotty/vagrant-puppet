class xebia-utils::wget{
    define fetch($source,$destination,$timeout=900) {
        exec { "wget-$name":
            command => "/usr/bin/wget --timeout=${timeout} --output-document=${destination} ${source} --no-check-certificate",
            creates => "${destination}",
            timeout => "${timeout}",
        }
    }
}