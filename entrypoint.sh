#!/bin/bash
set -e

# Valori di default se non specificati (opzionale)
: "${HOST:=celiani_db}"
: "${USER:=celiani_superuser}"

# Imposta la password per psql
export PGPASSWORD="qui8Tiv"

# Attendi che PostgreSQL sia pronto
echo "🔄 Attendo che il database PostgreSQL sia pronto su host '$HOST'..."
until pg_isready -h "$HOST" -p 5432 -U "$USER" > /dev/null 2>&1; do
  sleep 1
done

# Verifica se il database esiste
echo "🔍 Verifico se il database 'celianidb' esiste..."
DB_EXIST=$(psql -h "$HOST" -U "$USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='celianidb'")

if [ "$DB_EXIST" != "1" ]; then
  echo "🆕 Database non trovato. Eseguo inizializzazione..."
  /usr/bin/odoo \
    -d celianidb \
    --without-demo=all \
    --load-language=it_IT \
    -i base
else
  echo "✅ Database già presente. Avvio Odoo normalmente..."
  /usr/bin/odoo
fi