class apt_config {
    File {
        ensure  => present,
        replace => true,
        mode    => 644,
        owner   => root,
        group   => root,
    }

    #define aptfile($file) {
    #    file { "/etc/apt/${file}":
    #        ensure => present,
    #        source => "puppet:///modules/${module_name}/${file}",
    #    }
    #}
    #aptfile{ [ 'apt.conf', 'sources.list', ]: }

    file {
        '/etc/apt/apt.conf':
            ensure => present,
            source => "puppet:///modules/${module_name}/apt.conf";
        '/etc/apt/sources.list':
            ensure => present,
            source => "puppet:///modules/${module_name}/sources.list";
    }


    file { '/etc/apt/preferences.d/prefer_stable':
        ensure  => present,
        source  => "puppet:///modules/${module_name}/prefer_stable",
    }

    exec { "update package lists":
        command => '/usr/bin/apt-get update',
        user => root,
    }
}
