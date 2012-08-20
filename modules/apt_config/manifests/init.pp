class apt_config {
    File {
        ensure  => present,
        replace => true,
        mode    => 644,
        owner   => root,
        group   => root,
    }

    file {
        '/etc/apt/apt.conf':
            ensure => present,
            source => "puppet:///modules/${module_name}/apt.conf";
        '/etc/apt/preferences.d/prefer_stable':
            ensure  => present,
            source  => "puppet:///modules/${module_name}/prefer_stable";
        '/etc/apt/sources.list':
            ensure => present,
            source => "puppet:///modules/${module_name}/sources.list",
            require => File['/etc/apt/preferences.d/prefer_stable'];
    }

    exec { 'apt-update':
        command => '/usr/bin/apt-get update',
        user => root,
        subscribe => File['/etc/apt/sources.list'],
    }
}
