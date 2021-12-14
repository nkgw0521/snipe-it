#!/bin/sh
BKUPDIR=../snipe-it-backup

if [ ! -d $BKUPDIR ]; then
    mkdir $BKUPDIR
fi

# Restore
docker cp $BKUPDIR/snipeit.tar.gz snipeit:/var/tmp
docker exec snipeit tar x -vzh -f /var/tmp/snipeit.tar.gz -C /
docker exec -d snipeit rm /var/tmp/snipeit.tar.gz

docker cp $BKUPDIR/mysql-snipeit.sql snipe-it_mariadb_1:/var/tmp
docker exec snipe-it_mariadb_1 /bin/sh -c "mysql -u snipeit -pchangeme1234 < /var/tmp/mysql-snipeit.sql"
docker exec -d snipeit rm /var/tmp/mysql-snipeit.sql
