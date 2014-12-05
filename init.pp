import 'config.pp'

class { "base" :
  user  => "${user}",
  group => "${group}",
}

class { "ant" : 
  version => "1.9.4",
}

class { "maven" : 
  version => "3.2.3",
}

class { "gradle" : 
  version => "2.2",
}

class { "vagrant" :
  version => "1.6.5",
}

class { "vbox" :
  major_version  => "4.3",
  minor_version  => "18",
  patch_version  => "96516",
  ubuntu_version => "raring",
}
