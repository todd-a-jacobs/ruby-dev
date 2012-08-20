class virtualbox_guest_additions {
    # Note that Debian 6.x uses the OSE versions. This will change in
    # future.
    $packages = [
        'virtualbox-ose-guest-utils',
        'virtualbox-ose-guest-x11',
    ]

    package { $packages:
        ensure => 'installed',
    }
}
