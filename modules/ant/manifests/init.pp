class ant (
  $version      = "1.9.4",
  $destination  = "${software_base_folder}/ant",
  $mirror       = "http://apache.openmirror.de",
) inherits base {

  file { $destination :
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  exec { "download Apache Ant ${version}" :
    command => "/usr/bin/wget ${mirror}/ant/binaries/apache-ant-${version}-bin.zip",
    cwd     => "${download_folder}",
    onlyif  => "/usr/bin/test ! -e ${destination}/${version}/bin/ant",
    notify  => Exec["unpack Apache Ant ${version}"],
  }

  exec { "unpack Apache Ant ${version}" :
    command     => "/usr/bin/unzip ${download_folder}/apache-ant-${version}-bin.zip -d ${destination}",
    refreshonly => true,
    require     => File[$destination],
    notify      => Exec["move Apache Ant ${version}"],
  }

  exec { "move Apache Ant ${version}" :
    command     => "/bin/mv ${destination}/apache-ant-${version} ${destination}/${version}",
    refreshonly => true,
  }

  file { "${destination}/default" :
    ensure  => link,
    target  => "${destination}/${version}",
    require => [ File[$destination], Exec["move Apache Ant ${version}"] ],
  }

  file { "/home/${user}/bin/ant" :
    ensure  => link,
    target  => "${destination}/default/bin/ant",
    require => File["${destination}/default"],
  }
}
