class git {
    $git_packages = [
        git,
        git-gui,
        gitk,
        git-sh,
    ]
    package { $git_packages: ensure => installed, }

    $file_conversion_packages = [
        antiword,
        odt2txt,
        poppler-utils,
    ]
    package { $file_conversion_packages: ensure => installed, }

    File {
        ensure    => file,
        replace   => false,
        owner     => "${mortal_user}",
        group     => "${mortal_user}",
    }

    file {
      "/home/${mortal_user}/.gitattributes":
          source => 'puppet:///modules/git/.gitattributes';
      "/home/${mortal_user}/.gitconfig":
          source => 'puppet:///modules/git/.gitconfig';
      "/home/${mortal_user}/.gitignore":
          source => 'puppet:///modules/git/.gitignore';
    }
}
