class synchronization {
    $packages = [
        conduit,
        grsync,
        rsync,
        unison,
        unison-gtk,
    ]
    package { $packages: ensure => installed }
}
