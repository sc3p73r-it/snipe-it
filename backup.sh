#! /bin/bash
DATE=`date +"%Y-%m-%d-%H:%M"`
SQLFILE=/home/ubuntu/backups/database/${DATE}-snipeit-databasedump.sql
DATABASE= YOUR_DB
USER= YOUR_DB_USER
PASSWORD= YOUR_PASSWORD
# remove the previous version of the file
find /home/ubuntu/backups/database/* -mmin +1 -exec rm {} \;

# (3) do the mysql database backup (dump)
mysqldump -u ${USER} -p${PASSWORD} ${DATABASE}|gzip>${SQLFILE}.gz
FILES_DATE=`date +"%Y-%m-%d-%H:%M"`
FILE_BACKUP=/home/ubuntu/backups/file/${FILES_DATE}-snipe-it-filesdump
# (2) in case you run this more than once a day,
# remove the previous version of the file
find /home/ubuntu/backups/file/* -mmin +1 -exec rm {} \;

# (3) do the files backup
tar -czvf ${FILE_BACKUP}.tar.gz /var/www/snipe-it
