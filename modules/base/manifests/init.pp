class base(
  $user = undef, 
  $group = undef,
  $download_folder = "/home/${user}/Downloads",
  $software_base_folder = "/home/${user}/software",
) {
  
  if ( $user == undef ) {
    fail ("User is not defined!")
  }

  if ( $group == undef ) {
    fail ("Group is not defined!")
  }

  $base_packages = [ 
    'wget', 
    'unzip', 
    'git', 
    'curl', 
    'keepass2', 
    'ansible', 
    'chromium-browser', 
    'aptitude' 
  ]

  package { $base_packages :
    ensure => latest,
  }

  File {
    owner   => $user,
    group   => $group,
  }

  file { $software_base_folder :
    ensure  => directory,
  }

  file { "/home/${user}/bin" :
    ensure => directory,
  }

  file { "/home/${user}/Workspace" :
    ensure => directory,
  }
  
  file { "/home/${user}/.local/share/applications" :
    source  => "puppet:///modules/base/applications",
    recurse => true,
  }

  file { "/home/${user}/.bash_aliases" :
    source  => "puppet:///modules/base/.bash_aliases",
  }
  
}
