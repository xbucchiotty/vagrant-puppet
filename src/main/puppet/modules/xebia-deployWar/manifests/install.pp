class xebia-deployWar::install
(
    $listen_port ,
    $nexus_url ,
    $tomcat_service,
    $catalina_base ,
    $install_dir,
    $user,
    $group,
){
    file {
           "${install_dir}/deployWar.sh":
             content => template('xebia-deployWar/deploy.sh.erb'),
             ensure => present,
             mode => '0744',
             owner => "$user",
             group => "$group",
             require => Class['xebia-tomcat6']
     }

     package{'curl':
         ensure => present
     }
}
