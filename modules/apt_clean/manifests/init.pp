class apt_clean {
    exec { '/usr/bin/aptitude clean':
        user => root,
        require => Package['aptitude'],
    }
}
