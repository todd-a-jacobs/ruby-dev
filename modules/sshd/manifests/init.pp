class sshd { 
  include augeas_packages

  $packages = [
    openssh-server,
    openssh-blacklist,
    openssh-blacklist-extra,
  ]
  package { $packages: ensure => installed, }

  augeas { 'sshd_config':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      'set PermitRootLogin no',
    ],
  }
}
