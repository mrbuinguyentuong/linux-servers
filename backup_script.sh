#!/bin/bash
year=`date +"%Y"`
month=`date +"%m"`
day=`date +"%d"`
hour=`date +"%H_%M_%p"`
timestamp=`date '+%s'`
date="${day}_${month}_${year}"
datetime="${timestamp}_${day}_${month}_${year}_${hour}"
random_string=`cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 10 | head -n 1`
#Database information
db_user=""
db_password=""
db_name=""
sql_file_name="${db_name}_${datetime}_${random_string}.sql"

zip_file_name="${datetime}_${random_string}.zip"
#Defined path

path_save="/var/www/html/wp-content/uploads"

#Export database to folder
database_export=`mysqldump --user=${db_user} --password=${db_password} --default-character-set=utf8 ${db_name} > "${path_save}/${sql_file_name}"`

zip_command=`cd ${path_save} && zip -r "${zip_file_name}" *`
rclone_sync_to_google_drive=`rclone copy "${path_save}/${zip_file_name}" google_drive_backup:Backup`

#Delete zip & sql file
rm_zip_file=`rm "${path_save}/${zip_file_name}"`
rm_sql_file=`rm "${path_save}/${sql_file_name}"`
