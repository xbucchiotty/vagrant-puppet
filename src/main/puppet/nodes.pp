node /^node1.*$/{
	file {'/home/vagrant/hello-puppet-master':ensure=>present,}
}
