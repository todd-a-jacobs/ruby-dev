class rvm_build_dependencies {
    include 'apt_update'
    include 'git'
    $packages = [
        autoconf,
        bison,
        build-essential,
        curl,
        libc6-dev,
        libncurses5-dev,
        libreadline6,
        libreadline6-dev,
        libsqlite3-0,
        libsqlite3-dev,
        libssl-dev,
        libxml2-dev,
        libxslt1-dev,
        libyaml-dev,
        openssl,
        sqlite3,
        subversion,
        zlib1g,
        zlib1g-dev,
    ]
    package { $packages: ensure => installed, }
}
