# CONTAINERIZZARE POSTGRESS CON DOCKER

### Passaggi importanti

### Step 1: Verifica l'installazione di Docker
Come prima cosa verifichiamo la versione di docker installata sul pc.
Se Docker è installato correttamente, vedrai la versione installata.
Se hai bisogno di avviare Docker manualmente (su Linux):

```
sudo systemctl start docker
```
### Step 2: Fai un backup del tuo database esistente
Poiché hai già PostgreSQL installato e funzionante, esegui un backup per evitare perdite di dati.
Apri il terminale e accedi a PostgreSQL:
```
psql -U postgres
```
Mostra tutti i database:
```
\l
```
Sostituisci miodb con il tuo database:
```
pg_dump -U postgres -d miodb > backup.sql
```
### Step 3: Ferma e disinstalla PostgreSQL locale (opzionale)
Se vuoi usare solo il container, ferma PostgreSQL locale per evitare conflitti di porte:
```
sudo systemctl stop postgresql
```
Verifica che non sia più in esecuzione:
```
ps aux | grep postgres
```
Se vuoi riattivarlo in futuro:
```
sudo systemctl start postgresql
```

### Step 4: Avvia un container PostgreSQL con volume per la persistenza
Esegui il seguente comando per avviare PostgreSQL in Docker:
```
docker run -d \
  --name postgres-container \
  -e POSTGRES_USER=Celiani \
  -e POSTGRES_PASSWORD=mia_password \
  -e POSTGRES_DB=CelianiDB \
  -p 5432:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:latest
```
Cosa significa questo comando?

1. -d: Avvia il container in background
2. --name postgres-container: Nome del container
3. -e POSTGRES_USER=Celiani: Nome utente
4. -e POSTGRES_PASSWORD=mia_password: Password
5. -e POSTGRES_DB=CelianiDB: Nome del database predefinito
6. -p 5432:5432: Esponi la porta 5432
7. -v postgres_data:/var/lib/postgresql/data: Usa un volume per i dati

### Step 5: Verifica che il container sia in esecuzione
Controlla lo stato del container:
```
docker ps
```
Se è attivo, dovresti vedere qualcosa come:
```
CONTAINER ID   IMAGE      COMMAND                  STATUS         PORTS                    NAMES
abc123456789   postgres   "docker-entrypoint.s…"   Up X minutes   0.0.0.0:5432->5432/tcp   postgres-container
```

### Step 6: Ripristina il backup nel container
Copia il file backup.sql nel container:
```
docker cp backup.sql postgres-container:/backup.sql
```
Accedi al container:
```
docker exec -it postgres-container psql -U Celiani -d CelianiDB
```
Dentro PostgreSQL, esegui il restore:
```
\i /backup.sql
```
Esci da PostgreSQL:
```
\q
```
Ora i dati del tuo vecchio database sono stati importati nel nuovo container! 🎉

### Step 7: Test di connessione al database containerizzato
Prova a connetterti con:
```
psql -h localhost -U Celiani -d CelianiDB
```
Se funziona, hai completato la containerizzazione con successo!

### 📌 Comandi utili per gestire il container

1. Riavvia il container	docker restart postgres-container
2. Ferma il container	docker stop postgres-container
3. Avvia il container	docker start postgres-container
4. Controlla i log	docker logs postgres-container
5. Entra nel container	docker exec -it postgres-container bash
6. Rimuovi il container	docker rm -f postgres-container






# PRIMA INSTALLAZIONE

### Passaggi importanti

La prima cosa da fare è andare su GitHub e copiarsi il link del progetto Celiani, dopodiché seguire i seguenti passaggi:

1. Andare su Esplora risorse del PC e su C: creare una cartella **Celiani**.
2. Dopodiché eseguire il comando:

    ```powershell
    cd C:/Celiani
    git clone https://github.com/Codigo-Team/Celiani.git
    ```

Ora lanciamo il comando `code .` per aprire Visual Studio Code e lanciare il seguente comando:

    ```powershell
    python -m venv venv
    ```

E poi, per attivare l'ambiente virtuale, lanciare:

    ```powershell
    venv\Scripts\activate
    ```

**Nota:** Se ottieni un errore di esecuzione (execution policy restriction), esegui questo comando prima di attivare l'ambiente:

    ```powershell
    Set-ExecutionPolicy Unrestricted -Scope Process
    ```

Sempre nel path `C:/Celiani/Celiani/Odoo`, lanciare il seguente comando:

    ```powershell
    pip install -r C:\Celiani\Celiani\requirements.txt
    ```

Da qui possiamo procedere con l'installazione di PostgreSQL. La cartella in cui deve essere installato deve essere `C:\Program Files\PostgreSQL\17\`.

**PostgreSQL Server, pgAdmin e Command Line Tools sono OBBLIGATORI.**  
All'utente "postgres" impostiamo una password, quest'ultima servirà per la configurazione di Odoo. Ovviamente ho usato la password "qui8Tiv". Lasciare la porta predefinita "5432". Salvare e riavviare il PC.

Una volta riavviato, torniamo nella cartella di progetto `C:/Celiani/Celiani` e lanciamo il comando da `cmd`:

    ```cmd
    psql -U postgres
    ```

Se avete problemi che il comando non viene riconosciuto, è necessario innanzitutto copiare il path della cartella `bin` di PostgreSQL: `C:\Program Files\PostgreSQL\17\bin`. Dopodiché, aprire Esplora risorse e fare tasto destro su "Questo PC" e scegliere **Proprietà**.

1. Vai su "Impostazioni di sistema avanzate" e poi su "Variabili d'ambiente".
2. Nella sezione "Variabili di sistema", cerca e seleziona la variabile **Path**, poi clicca su "Modifica".
3. Aggiungi il percorso della cartella `bin` di PostgreSQL alla fine del valore della variabile **Path**.
4. Salva le modifiche e chiudi tutte le finestre.
5. Apri una nuova finestra del prompt dei comandi e digita `psql -U postgres`.

Ora dovrebbe funzionare correttamente.

Dopo aver lanciato il comando `psql -U postgres`, avrete la possibilità di creare il database e gli utenti in questo modo:

    ```cmd
    CREATE USER celiani WITH ENCRYPTED PASSWORD 'qui8Tiv';
    CREATE DATABASE celiani OWNER celiani;
    ALTER ROLE celiani SET client_encoding TO 'utf8';
    ALTER ROLE celiani SET default_transaction_isolation TO 'read committed';
    ALTER ROLE celiani SET timezone TO 'UTC';
    GRANT ALL PRIVILEGES ON DATABASE celiani TO celiani;
    ```

Ora bisogna modificare il file `odoo.conf` in questo modo:

    ```
    [options]
    admin_passwd = admin
    db_host = localhost
    db_port = 5432
    db_user = celiani
    db_password = tua_password
    db_name = celiani
    addons_path = C:\Celiani\Celiani\odoo\addons, c:\users\ivang\appdata\local\openerp s.a\odoo\addons\18.0
    logfile = C:\Celiani\Celiani\odoo\odoo.log
    ```

Dovrete modificare l'`addons_path` con il vostro percorso di cartella per poter lanciare in localhost correttamente, altrimenti non partirà mai. Ovviamente, ad ogni commit, ricordatevi di escludere questa modifica, altrimenti ogni volta avremo problemi.

Il comando che lanceremo ogni volta per avviare il progetto sarà il seguente:

    ```cmd
    python odoo-bin -d celiani_db -i base --db_user=celiani --db_password=qui8Tiv
    ```

Per accedere al login usare le credenziali: `admin - admin`.
