class resolvconf {
    package { 'resolvconf': } -> file { '/etc/resolvconf/resolv.conf.d/base':
        ensure  => file,
        owner   => root,
        group   => root,
        content => '
nameserver 127.0.0.1
nameserver 8.8.8.8
nameserver 8.8.4.4',
        require => Package['resolvconf'],
    } -> package { 'dnsmasq': }
}
