## operating system configs for webserver (apache is handled in a separate file

## webserver firewall config
class my_fw::pre {
  Firewall {
    require => undef,
  }
  
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }-->
  firewall { '002 allow http and https access':
    dport  => [80, 443],
    proto  => 'tcp',
    action => 'accept',
  }
  firewall { '010 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '020 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  }->
  firewall { '030 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
})

#drop all packets that arent allowed 'deny any any'
class my_fw::post {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}


