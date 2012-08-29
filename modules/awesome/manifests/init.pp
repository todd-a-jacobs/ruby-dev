class awesome {
    $packages = [
        awesome,
        awesome-extra,
    ]
    package { $packages: ensure => installed }

    File {
        owner   => "${mortal_user}",
        group   => "${mortal_user}",
    }

    file {
	"/home/${mortal_user}/.config":
	    ensure  => directory;
	"/home/${mortal_user}/.config/awesome":
	    ensure  => directory;
	"/home/${mortal_user}/.config/awesome/rc.lua":
	    require => Package['awesome'],
	    source  => "puppet:///modules/awesome/home/$mortal_user/.config/awesome/rc.lua",
	    ensure  => file,
	    mode    => 0664,
    }

    # Default to using the awesome window manager.
    file { "/home/${mortal_user}/.dmrc":
        ensure  => file,
        mode    => 0664,
        owner   => "$mortal_user",
        group   => "$mortal_user",
        content => "\n[Desktop]\nSession=awesome",
        replace => false,
    }
}
