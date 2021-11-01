DATE=`date +%Y-%m-%d`

echo `date`

pg_dump cop4710 > db_backup_$DATE.sql -U postgres

