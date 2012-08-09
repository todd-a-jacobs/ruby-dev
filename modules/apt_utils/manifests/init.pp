class apt_utils {
    include 'apt_config'

    $packages = [
        aptitude,
        apt-show-versions,
        cron-apt,
    ]
    package { $packages: ensure => installed, }
}
