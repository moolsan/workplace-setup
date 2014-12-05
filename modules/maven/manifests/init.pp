class maven (
  $version      = "3.2.3",
  $destination  = "${software_base_folder}/maven",
  $mirror       = "http://apache.openmirror.de",
) inherits base {
  
  # http://apache.openmirror.de/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.zip

  file { $destination :
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  exec { "download Apache Maven ${version}" :
    command => "/usr/bin/wget ${mirror}/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.zip",
    cwd     => "${download_folder}",
    onlyif  => "/usr/bin/test ! -e ${destination}/${version}/bin/mvn",
    notify  => Exec["unpack Apache Maven ${version}"],
  }

  exec { "unpack Apache Maven ${version}" :
    command     => "/usr/bin/unzip ${download_folder}/apache-maven-${version}-bin.zip -d ${destination}",
    refreshonly => true,
    require     => File[$destination],
    notify      => Exec["move Apache Maven ${version}"],
  }

  exec { "move Apache Maven ${version}" :
    command     => "/bin/mv ${destination}/apache-maven-${version} ${destination}/${version}",
    refreshonly => true,
  }

  file { "${destination}/default" :
    ensure  => link,
    target  => "${destination}/${version}",
    require => [ File[$destination], Exec["move Apache Maven ${version}"] ],
  }

  file { "/home/${user}/bin/mvn" :
    ensure  => link,
    target  => "${destination}/default/bin/mvn",
    require => File["${destination}/default"],
  }

}
