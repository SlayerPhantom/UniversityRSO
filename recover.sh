DATE=`date +%Y-%m-%d`
echo `date`

createdb cop4710 -U postgres
psql cop4710 < db_backup_$DATE.sql -U postgres

