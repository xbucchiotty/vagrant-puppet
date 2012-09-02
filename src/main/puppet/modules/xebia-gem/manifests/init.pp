class xebia-gem($temporary_directory="/tmp") {
    include xebia-utils

    package {
        'librack-ruby':ensure => present;
        'irb':ensure => present;
        'build-essential':ensure => present;
        'libmysql-ruby':ensure => present;
        'libmysqlclient-dev':ensure => present;
        'libopenssl-ruby':ensure => present;
        'rake':ensure => present;
        'rdoc':ensure => present;
        'ri':ensure => present;
        'ruby':ensure => present;
        'ruby-dev':ensure => present;
    }

    xebia-utils::wgetanduntar::install{'install gems':
        source                  => 'http://production.cf.rubygems.org/rubygems/rubygems-1.3.7.tgz',
        wget_timeout            => 9000,
        installation_directory  => "${temporary_directory}",
        temporary_file_name     => 'rubygems-1.3.7.tgz',
        destination             => "${temporary_directory}/rubygems-1.3.7/",
    }

    exec{'install gems':
        command => '/usr/bin/ruby setup.rb',
        cwd => "${temporary_directory}-1.3.7",
        refreshonly => true,
        notify =>  Exec['updates /usr/bin/gems'],
    }

    exec{'updates /usr/bin/gems':
        command => '/usr/bin/update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.8 1',
        refreshonly => true,
    }

}
