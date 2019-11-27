#!/usr/bin/perl
use strict;

print "username: ";
$input0 = <STDIN>;
print "password: ";
$input1 = <STDIN>;

chomp ($input0);
chomp ($input1);

print "Result: " . $input0 .":".crypt($input1,$input1)."\n";

