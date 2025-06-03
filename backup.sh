#!/bin/bash
 
docker exec celiani_db pg_dump -U celiani_superuser celianidb > backup.sql
echo "Backup salvato in backup.sql"