class xebia-tomcat6 {
package { 'tomcat6':
    require => Class['xebia-jdk6'],
    ensure => present,
}
 
group{'tomcat6':
   ensure => present,
}

user{'tomcat6':
   ensure => present,
   gid => 'tomcat6',
}

file{'/usr/share/tomcat6/':
    ensure => directory,
    owner  => 'tomcat6',
    recurse=> true,
    group  => 'tomcat6',
    require=> [Package['tomcat6'],User['tomcat6'],Group['tomcat6']]
}

service { 'tomcat6':
    ensure => running,
    require => File['/usr/share/tomcat6/'],
}

}
