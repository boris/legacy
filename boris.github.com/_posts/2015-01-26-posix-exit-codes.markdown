---
layout: post
title: POSIX exit codes
date: 2015-01-26 00:00:00.000000000 -03:00
---
On POSIX systems, UNIX and Linux, programs can report to its parent process when they finish. This "report" is a number, for example 0 and 1 where "0" is "success" and "1" is "WTF? this shit is broken", and so on to 255.

It should be an stadard, but sometimes... 

## Upstart

[Upstart](http://upstart.ubuntu.com/) is a daemon that reads the exit codes of a process and according to that, it can do something (restart, notify, etc), but there is a weird condition when Upstart will **not** be notified of the correct exit code. Here is an example:

```
#/bin/bash
touch /root/test
echo "success!"
```

If we execute this script above as a non-root user, it will report:

```
$ ./test.sh
touch: cannot touch `/root/test`: Permission denied
success!
```

And if we check the latest exit code we should see the number 1, because we could not create the `test` file:

```
$ echo $?
0
```

WHAT?! The command above **did not** succeed, as it could not create an empty file on `/root` directory. So, why it returned an `exit 0`? Because of the `echo "success!"`. The last part of the script was in deed susccessful, so the `exit 0` is correct, but it is not correct if we ask ourselves: `was the aplication able to create the file?`. No, it was not.

### Fixing the example

It is important to know the **real** exit code of an application, in this case the comment is not necessary, so it could be removed and it will help us to fix the problem with the exit code of our small script:

```
#/bin/bash
touch /root/test
```

After the fix:

```
$ ./test.sh
touch: cannot touch `/root/test`: Permission denied
$ echo $?
1
```

## Conclusion
When writing code, always be careful with how you application manage exit codes, and what to code have to do if something fails. The most important thing is not write to logs when something fails, it is most importat to provide the right exit code so upstart (or any other event-based daemon) could hande the syscall and _do something_ about it.
