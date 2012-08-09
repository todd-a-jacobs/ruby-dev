class virtual_displays {
    $packages = [
        byobu,
        screen,
        ssvnc,
        tmux,
        vnc4server,
        xvnc4viewer,
    ]
    package { $packages: ensure => installed }
}
