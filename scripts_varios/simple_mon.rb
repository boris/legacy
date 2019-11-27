#!/usr/bin/env ruby

print "Process to monitor? "
name = gets.chomp
print "Monitoring #{name}\n"
print "------------------\n"
print "USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND\n"
system("ps aux | grep #{name} | grep -v grep");
