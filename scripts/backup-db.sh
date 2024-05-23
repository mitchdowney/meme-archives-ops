#!/usr/bin/env bash

echo "Starting backup function"

CONTAINER_NAME='meme_archives_db'
SOURCE_DIR="$(docker volume inspect --format '{{ .Mountpoint }}' docker_db_backup)"
DAYS_TO_KEEP=7

# daily backups
# dump db

docker exec -it ${CONTAINER_NAME} bash -c 'DATE="$(date +'%Y-%m-%d')"; pg_dump -Fp -U "user" "db" | zstd -9 --rsyncable > "/mnt/${DATE}-db.sql.zst.in_progress" && mv "/mnt/${DATE}-db.sql.zst.in_progress" "/mnt/${DATE}-db.sql.zst"'

# upload to cloud storage

# take contents of source directory and upload to cloud

# cleanup
echo "Find and remove old backups, before creating new one"
echo "The following will be removed:"
find "${SOURCE_DIR}" -maxdepth 1 -mtime +${DAYS_TO_KEEP} -name "*-daily" -print -exec rm -rfv {} \;
