#!/usr/bin/perl
use strict;

my @services = ( 'httpd', 'Twitter' );
my $host = `/bin/hostname`;
chomp $host;

foreach my $service (@services) {
   my $status = `/bin/ps cax | /usr/bin/grep $service`;
   my $info = `/bin/ps aux | /usr/bin/grep httpd | awk \'{print \$2}\'`;
   if (!$status) {
      print $service . " Not running \n";
   }
   else {
      print $service . " Running\n";
      print "PID: " . $info ;
   }
}
