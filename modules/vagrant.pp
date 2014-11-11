class vagrant (
  $version      = "1.6.5",
) inherits workplace::base {

  exec { "download Vagrant ${version}" :
    command => "/usr/bin/wget https://dl.bintray.com/mitchellh/vagrant/vagrant_${version}_x86_64.deb",
    cwd     => "${download_folder}",
    creates => "${download_folder}/vagrant_${version}_x86_64.deb",
    onlyif  => "/usr/bin/test \"$(vagrant --version)\" != \"Vagrant ${version}\"",
    notify  => Exec["install Vagrant ${version}"],
  }

  exec { "install Vagrant ${version}" :
    command => "/usr/bin/dpkg -i vagrant_${version}_x86_64.deb",
    cwd     => "${download_folder}",
  }
  
}
