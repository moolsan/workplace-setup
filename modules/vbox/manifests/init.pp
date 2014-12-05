class vbox(
  $major_version  = "4.3",
  $minor_version  = "18",
  $patch_version  = "96516",
  $ubuntu_version = "raring",
) inherits base {

  $version = "${major_version}.${minor_version}"
  $filename = "virtualbox-${major_version}_${version}-${patch_version}~Ubuntu~${ubuntu_version}_amd64.deb"
  $url = "http://download.virtualbox.org/virtualbox/${major_version}.${minor_version}/${filename}"

  exec { "download VirtualBox ${version}" :
    command => "/usr/bin/wget ${url}",
    cwd     => "${download_folder}",
    creates => "${download_folder}/${filename}",
    notify  => Exec["install VirtualBox ${version}"],
  }

  exec { "install VirtualBox ${version}" :
    command => "/usr/bin/dpkg -i ${filename}",
    cwd     => "${download_folder}",
    refreshonly => true,
  }

}
