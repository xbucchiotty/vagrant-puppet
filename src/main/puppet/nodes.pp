class init{
		exec { 'apt-get update':
			command => '/usr/bin/apt-get update',
		}
}

node /^node.*$/{

	include xebia-jdk6,xebia-tomcat6
	
	stage { pre: before => Stage[main] }
	
	class {'init':
		stage => pre,
	}
	
	exec{'/etc/hosts':
		command => "/bin/echo \"192.168.56.203  nexus\" >> /etc/hosts",
		unless  => '/bin/grep nexus /etc/hosts',
	}
	
	class{'xebia-deployWar':
		listen_port => '8080',
		nexus_url   => 'nexus:8081/nexus',
		install_dir => '/usr/share/tomcat6/bin',
		catalina_base => '/var/lib/tomcat6',
		user => 'tomcat6',
	}

	xebia-deployWar::deploy{'deploy org.xbucchiotty:PetClinicSample':
    groupId     => 'fr.xebia.xke',
    artifactId  => 'vagrant-puppet',
    version     => 'LATEST',
    install_dir => '/usr/share/tomcat6/bin',
}

	
}

class init-nexus{
	xebia-utils::aptget::update{'nexus-aptgetupdate':
		refreshonly => false,
	}
}
	
node /^puppet.*$/{
	stage { pre: before => Stage[main] }
	
	include xebia-utils
	
	
	
	class{'init-nexus':
		stage => pre
	}
		
	class { 'xebia-jdk6' :
		require => Exec['apt-get update'],
	}
	
	class { 'xebia-nexus' :
		nexus_version       =>  "2.0.5",
		temporary_directory => '/home/vagrant',
		install_dir         => '/home/vagrant',
		require => Class['xebia-jdk6'],
	}
	
}
