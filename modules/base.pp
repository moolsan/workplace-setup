class workplace::base(
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

  $needed_packages = [ 'wget', 'unzip', 'git' ]

  package { $needed_packages :
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
}
