class puppet {
  package { 'puppet': ensure => installed, }
  group { "puppet":
    ensure => "present",
  } 
}
