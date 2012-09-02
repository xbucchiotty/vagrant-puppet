stage { pre: before => Stage[main] }

class init{
	exec { "apt-get update":
            command => '/usr/bin/apt-get update',
        }
}

class{'init':
	stage => pre
}


exec{'/etc/hosts/puppet':
    command => '/bin/echo \'192.168.56.205  foreman.xebia.fr foreman\' >> /etc/hosts',
    unless  => '/bin/grep 203 /etc/hosts',
}

exec{'/etc/hosts/node1':
    command => '/bin/echo \'192.168.56.204  node1.xebia.fr node1\' >> /etc/hosts',
    unless  => '/bin/grep 204 /etc/hosts',
}

package{'vim-puppet':
	ensure => present,
}

file{'/etc/puppet':
	ensure => directory,
	owner  => vagrant,
	group  => vagrant,
}

file{'/var/lib/puppet/reports/':
    	ensure => directory,
    	owner => vagrant,
    	group => vagrant,
}	

file{'/var/lib/puppet/reports/foreman':
    	ensure => directory,
    	owner => vagrant,
    	group => vagrant,
    	require => File['/var/lib/puppet/reports/'],
}	

file{'/var/lib/puppet':
    	ensure => directory,
    	owner => vagrant,
    	group => vagrant,
        recurse => true,
}	

file{'/etc/puppet/puppet.conf':
	ensure => present,
	owner  => vagrant,
	group  => vagrant,
	content => '[master]
certname=foreman.xebia.fr
user=vagrant
group=vagrant

manifest                = /vagrant/src/main/puppet/site.pp
manifestdir             = /vagrant/src/main/puppet/
modulepath              = /vagrant/src/main/puppet/modules

[agent]
server=foreman.xebia.fr
user=vagrant
group=vagrant',
}