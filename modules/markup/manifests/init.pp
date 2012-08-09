class markup {
    $packages = [
        asciidoc,
        markdown,
        pandoc,
        txt2tags,
    ]
    package { $packages: ensure => installed, }
}
