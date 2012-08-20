class apt_clean {
    exec { '/usr/bin/apt-get clean':
        user => root,
    }
}
