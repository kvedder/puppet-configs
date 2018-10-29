#################################################################
#																#
# Configuration for the apache website to serve staic content	#
#																#
#################################################################

class apache {

	$adminemail = 'webmaster@kvedder.com'

	#ensure apache is installed
  package { 'apache':
    ensure  => present,

  }

  service { 'apache2':

  	enable      => true,
  	ensure      => running,
  	#hasrestart => true,
  	#hasstatus  => true,

  	}
	
  #ensure apache log directory is present
  file { '/var/log/apache':
  	ensure => 'directory',
  }

}

# ensures that the config file for the apache vhost is present
file { "/etc/apache2/sites-available/static.conf":
    ensure => "present",
    content => template("apache/vhost.erb") 
}    
