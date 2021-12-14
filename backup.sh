#!/bin/sh
BKUPDIR=../snipe-it-backup

if [ ! -d $BKUPDIR ]; then
    mkdir $BKUPDIR
fi

# Backup
docker exec snipeit tar c -vzh -f /var/tmp/snipeit.tar.gz -C / var/www/html/.env var/www/html/public/uploads/ var/www/html/storage/oauth-private.key var/www/html/storage/oauth-public.key
docker cp snipeit:/var/tmp/snipeit.tar.gz $BKUPDIR
docker exec -d snipeit rm /var/tmp/snipeit.tar.gz

docker exec snipe-it_mariadb_1 mysqldump -u snipeit -pchangeme1234 --all-databases > $BKUPDIR/mysql-snipeit.sql
