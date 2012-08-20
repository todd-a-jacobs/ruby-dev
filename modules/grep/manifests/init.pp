class grep {
   include apt_utils

    $packages = [
       ack-grep,
       agrep,
       grep,
       pcregrep,
       pdfgrep,
       sgrep,
       tre-agrep,
       xmlstarlet,
    ]
    package { $packages: ensure => installed, }
}
