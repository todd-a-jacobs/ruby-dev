class resolvconf {
    $packages = ['resolvconf', 'dnsmasq']
    package { $packages: ensure => installed, }

    file { '/etc/resolvconf/resolv.conf.d/base':
        ensure  => file,
        owner   => root,
        group   => root,
        content => '
nameserver 127.0.0.1
nameserver 8.8.8.8
nameserver 8.8.4.4',
    }

    service { 'dnsmasq':
        require   => Package[resolvconf],
        ensure    => running,
        subscribe => File['/etc/resolvconf/resolv.conf.d/base']
    }
}
