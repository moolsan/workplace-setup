#
# Puppet w/ Shell bootstrap
# Ant
# Maven
# Gradle
# STS
# IDEA
# JMeter
# Vagrant
# VirtualBox
# SublimeText (2/3?)
# Ansible
# Docker
#


# puppet module install maestrodev-wget


# user and group of the workspace
$user   = "bs"
$group  = "bs"

# workspace base settings
$user_folder          = "/home/${user}"
$software_base_folder = "${user_folder}/software"
$download_folder      = "${user_folder}/Downloads"


class bootstrap {
  
  $needed_packages = [ 'wget', 'unzip', 'git' ]

  package { $needed_packages :
    ensure => latest,
  }

  file { $software_base_folder :
    ensure  => directory,
    owner   => $user,
    group   => $group,
  }

}

class ant(
  $version      = "1.9.4",
  $destination  = "${software_base_folder}/ant",
  $mirror       = "http://apache.openmirror.de",
) {

  include wget

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
    command => "/bin/mv ${destination}/apache-ant-${version} ${destination}/${version}",
    refreshonly => true,
  }

  file { "${destination}/default" :
    ensure  => link,
    target  => "${destination}/${version}",
    require => [ File[$destination], Exec["move Apache Ant ${version}"] ],
  }

}

Class['bootstrap'] ->
  Class ['ant']

include bootstrap
include ant
