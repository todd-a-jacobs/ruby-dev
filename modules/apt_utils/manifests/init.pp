class apt_utils {
    $packages = [
        aptitude,
        apt-show-versions,
        cron-apt,
    ]
    package { $packages: ensure => installed, }
}
