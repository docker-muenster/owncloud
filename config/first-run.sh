#!/bin/bash
set -e

if [ -z "$ADMIN_PASSWORD" ]; then
  exit 1
fi
ADMIN_USERNAME=${ADMIN_USERNAME:-admin}

if [ ! -e '/var/www/html/version.php' ]; then
	tar cf - --one-file-system -C /usr/src/owncloud . | tar xf -

  # sleep 15
  until netcat -z -w 2 mysql 3306; do sleep 1; done

  php occ maintenance:install \
    --database "mysql" \
    --database-name "owncloud" \
    --database-host "mysql" \
    --database-user "root" \
    --database-pass "password" \
    --admin-user "$ADMIN_USERNAME" \
    --admin-pass "$ADMIN_PASSWORD" \
    -vv \
    --no-interaction

	chown -R www-data /var/www/html
fi

exec apache2-foreground
