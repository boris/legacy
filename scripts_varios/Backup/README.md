# Simple Backup to AWS
This is a very simple set of scripts I use to backup data to Amazon S3.

## Install
Install process is very easy:
```bash
git clone https://github.com/boris/BackupAWS /var/opt/
chmod +x /var/opt/BackupAWS/backup.sh

# Add following to root crontab:
00 23 * * * /var/opt/BackupAWS/backup.sh
```

## Configure
On [`mail.sh`][mail.sh] change vairables `subject` and `email`.

On [`mysql.sh`][mysql.sh] you have to modify `user`, `pass` and `dbs` with the correct information to backup your databases. Also, you need to modify `rdir` with the correct S3 Bucket to store your backups.

On [`sites.sh`][sites.sh] modify `sites` variable. For example: `/var/www`.

[backup.sh]: https://github.com/boris/Scripts-varios/blob/rasp-pi/Backup/backup.sh
[mail.sh]: https://github.com/boris/Scripts-varios/blob/rasp-pi/Backup/services/mail.sh
[mysql.sh]: https://github.com/boris/Scripts-varios/blob/rasp-pi/Backup/services/mysql.sh
[sites.sh]: https://github.com/boris/Scripts-varios/blob/rasp-pi/Backup/services/sites.sh
