class browsers {
    $browsers = [
        iceweasel,
        chromium-browser,
    ]

    $browser_extensions = [
        iceweasel-downthemall,
        flashplugin-nonfree,
        foxyproxy,
        xul-ext-adblock-plus,
        xul-ext-firebug,
        xul-ext-noscript,
    ]

    package { [$browsers, $browser_extensions]: ensure => installed }
}
