class libreoffice {
    $openoffice = [
        openoffice.org,
        openclipart,
    ]

    $libreoffice = [
        libreoffice,
        libreoffice-openclipart,
        libreoffice-openclipart2,
    ]

    # Squeeze still uses OpenOffice.org, not LibreOffice. Should replace
    # this with a conditional based on the distro version.
    package { $openoffice: ensure => installed, }
}
