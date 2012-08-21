class xebia-deployWar
(
        $listen_port      = '80',
        $nexus_url        = 'nexus',
        $catalina_base    = '/var/lib/tomcat6',
        $tomcat_service   = 'tomcat6',
	    $user		      = 'tomcat6',
	    $group            = 'tomcat6',
        $install_dir,
 ){

  class { 'xebia-deployWar::install':
        listen_port     => $listen_port,
        nexus_url       => $nexus_url,
        catalina_base   => $catalina_base,
        tomcat_service  => $tomcat_service,
        install_dir     => $install_dir,
        user 		    => $user,
        group           => $group,
  }

  define deploy
  (
      $artifactId,
      $groupId,
      $version='LATEST',
      $install_dir,
      $timeout='30',
  ){
      exec{"deploy ${groupId}.${artifactId}:${version} on tomcat":
        command     =>  "${install_dir}/deployWar.sh ${groupId} ${artifactId} ${timeout} ${version}",
	logoutput   => true,
        require     => Class['xebia-tomcat6'],
      }
  }
}
