class make_sandbox_directory {
    file { "/home/${mortal_user}/sandbox":
        ensure  => directory,
        owner   => "$mortal_user",
        group   => "$mortal_user",
    }
}
