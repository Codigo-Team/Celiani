# Definisci la cartella dove sarà salvato docker-compose.yml
$odooPath = "C:\WebApp\Celiani

# Contenuto del file docker-compose.yml
$composeContent = @'
version: "3.1"

services:
  celiani-db:
    image: postgres:15
    container_name: celiani-db
    environment:
      - POSTGRES_DB=celianidb
      - POSTGRES_USER=celiani_superuser
      - POSTGRES_PASSWORD=qui8Tiv
    volumes:
      - celiani-db-data:/var/lib/postgresql/data
    restart: always

  odoo:
    image: odoo:18
    container_name: celiani-odoo
    depends_on:
      - celiani_db
    ports:
      - "8069:8069"
    environment:
      - HOST=celiani_db
      - USER=celiani_superuser
      - PASSWORD=qui8Tiv
    volumes:
      - ./addons:/mnt/extra-addons
    restart: always

volumes:
  celiani-db-data:
'@

# Crea il file docker-compose.yml nella cartella specificata
Set-Content -Path "$odooPath\docker-compose.yml" -Value $composeContent -Encoding UTF8
