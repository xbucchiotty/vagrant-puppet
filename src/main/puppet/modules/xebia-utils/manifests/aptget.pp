class xebia-utils::aptget{

    define update($refreshonly=true){
        exec { 'apt-get update':
            command => '/usr/bin/apt-get update',
            refreshonly => $refreshonly,
        }
    }
}