class grep {
   include apt_utils

    $packages = [
       ack-grep,
       xmlstarlet,
       agrep,
       sgrep,
       tre-agrep,
       grep,
       pcregrep,
       pdfgrep,
    ]
    package { $packages: ensure => installed, }
}
