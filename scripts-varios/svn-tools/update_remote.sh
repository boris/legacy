#!/usr/bin/expect -f

set REPOS [lindex $argv 0]
set REV [lindex $argv 1]

# Set with you variables
# Your remote host
set HOST rc.example.com

# The path to rc.example.com Directory
set PATH /path/to/remote

# Login credentials
set USER username
set PASSWD password

# Here comes the magic
spawn /usr/bin/ssh $USER@$HOST svn update $PATH
expect "continue connecting (yes/no)? "
send "yes\r"
expect "password: "
send "$PASSWD\r"
expect eof
