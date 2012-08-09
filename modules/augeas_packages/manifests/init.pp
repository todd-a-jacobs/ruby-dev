class augeas_packages {
    $packages = [
        augeas-lenses,
        augeas-tools,
        libaugeas-ruby,
    ]
    package { $packages: ensure => installed, }
}
