class gradle (
  $version      = "2.2",
  $destination  = "${software_base_folder}/gradle",
  $mirror       = "https://services.gradle.org/distributions/",
) inherits base {
  
  file { $destination :
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  exec { "download Gradle ${version}" :
    command => "/usr/bin/wget ${mirror}/gradle-${version}-bin.zip",
    cwd     => "${download_folder}",
    onlyif  => "/usr/bin/test ! -e ${destination}/${version}/bin/gradle",
    notify  => Exec["unpack Gradle ${version}"],
  }

  exec { "unpack Gradle ${version}" :
    command     => "/usr/bin/unzip ${download_folder}/gradle-${version}-bin.zip -d ${destination}",
    refreshonly => true,
    require     => File[$destination],
    notify      => Exec["move Gradle ${version}"],
  }

  exec { "move Gradle ${version}" :
    command     => "/bin/mv ${destination}/gradle-${version} ${destination}/${version}",
    refreshonly => true,
  }

  file { "${destination}/default" :
    ensure  => link,
    target  => "${destination}/${version}",
    require => [ File[$destination], Exec["move Gradle ${version}"] ],
  }

  file { "/home/${user}/bin/gradle" :
    ensure  => link,
    target  => "${destination}/default/bin/gradle",
    require => File["${destination}/default"],
  }

}
