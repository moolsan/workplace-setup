class vagrant (
  $version      = "1.6.5",
) inherits workplace::base {

  $vagrant_dl_base = ""
  $vbox_dl_base = ""

  exec { "download Vagrant ${version}" :
    command => "/usr/bin/wget https://dl.bintray.com/mitchellh/vagrant/vagrant_${version}_x86_64.deb",
    cwd     => "${download_folder}",
    creates => "${download_folder}/vagrant_${version}_x86_64.deb",
    notify  => Exec["install Vagrant ${version}"],
  }

  exec { "install Vagrant ${version}" :
    command => "/usr/bin/dpkg -i vagrant_${version}_x86_64.deb",
    cwd     => "${download_folder}",
  }

# http://download.virtualbox.org/virtualbox/4.3.18/virtualbox-4.3_4.3.18-96516~Ubuntu~raring_amd64.deb

  exec { "download VirtualBox " :
    command => "/usr/bin/wget ",
    cwd     => "${download_folder}",
    creates => "${download_folder}/",
  }

}
