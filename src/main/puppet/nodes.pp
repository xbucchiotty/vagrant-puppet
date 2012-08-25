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

	xebia-deployWar::deploy{'deploy application':
		groupId     => 'fr.xebia.xke',
    		artifactId  => 'vagrant-puppet',
    		version     => 'LATEST',
    		install_dir => '/usr/share/tomcat6/bin',
	}
	
}

class init{
	xebia-utils::aptget::update{'puppet-aptgetupdate':
		refreshonly => false,
	}
}
	
node /^puppet.*$/{
	stage { pre: before => Stage[main] }
	
	include xebia-utils
	include xebia-mysqld	

	
	class{'init':
		stage => pre
	}
		
	include 'xebia-jdk6'
	
	class { 'xebia-nexus' :
		nexus_version       =>  "2.0.5",
		temporary_directory => '/home/vagrant',
		install_dir         => '/home/vagrant',
		require => Class['xebia-jdk6'],
	}
	
	class{'xebia-gem':
		temporary_directory =>  '/home/vagrant',
	}
	
	class { 'xebia-puppetdashboard' :
		require => [Class['xebia-mysqld'],Class['xebia-gem']],
		temporary_directory => '/home/vagrant',
	}
	
	#class{'xebia-theforeman':
	#	require => [Class['xebia-mysqld'],Class['xebia-gem']],
	#	temporary_directory => '/home/vagrant',
	#}
	
	xebia-mysqld::config::mysqldb{'vagrant':
		user => vagrant,
		password => vagrant,
		host => '%'
	}	
	
}
