#
# Puppet w/ Shell bootstrap +
# Ant +
# Maven +
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

import "modules/*"

class { "ant" : 
  version => "1.9.4",
}

class { "maven" : 
  version => "3.2.3",
}
