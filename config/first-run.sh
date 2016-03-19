#!/bin/bash

if [ -z "$ADMIN_PASSWORD" ]; then
  exit 1
fi
ADMIN_USERNAME=${ADMIN_USERNAME:-admin}

if [ ! -e '/var/www/html/version.php' ]; then
	tar cf - --one-file-system -C /usr/src/owncloud . | tar xf -

  # docker-php-ext-install pcntl

  while :; do
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

    if [[ $? == 0 ]]; then break; fi
    sleep 1
  done

	chown -R www-data /var/www/html
fi

exec apache2-foreground
