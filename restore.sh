#!/bin/bash
 
if [ ! -f backup.sql ]; then
  echo "File backup.sql non trovato!"
  exit 1
fi
 
docker exec -i celiani_db psql -U celiani_superuser celianidb < backup.sql
echo "Restore completato da backup.sql"