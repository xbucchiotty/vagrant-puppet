exec{'/etc/hosts/puppet':
    command => '/bin/echo \'192.168.56.203  puppet.xebia.fr puppet\' >> /etc/hosts',
    unless  => '/bin/grep 203 /etc/hosts',
}

exec{'/etc/hosts/node1':
    command => '/bin/echo \'192.168.56.204  node1.xebia.fr node1\' >> /etc/hosts',
    unless  => '/bin/grep 204 /etc/hosts',
}

file{'/etc/puppet':
	ensure => directory,
	owner  => vagrant,
	group  => vagrant,
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
certname=puppet.xebia.fr
user=vagrant
group=vagrant

manifest                = /vagrant/src/main/puppet/site.pp
manifestdir             = /vagrant/src/main/puppet/
modulepath              = /vagrant/src/main/puppet/modules

reports=http
reporturl=http://puppet:3000/reports/upload

[agent]
server=puppet.xebia.fr
user=vagrant
group=vagrant
report = true',
}