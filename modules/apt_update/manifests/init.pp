class apt_update {
    include apt_config
    include apt_utils
    exec { '/usr/bin/aptitude update': }
}
