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
