# PRIMA INSTALLAZIONE ODOO DOCKERIZZATO

### Passaggi importanti
Come prima cosa ci cloniamo il progetto in una cartella. Entrare nella cartella in questione e da qui aprite un prompt comandi (come amministratore) e lanciate il seguente comando:

```
docker-compose up -d
```

Questo comando andrà a leggere la configurazione presente all'interno del file ' docker-compose.yml '.Una volta lanciato il comando docker se andando in localhost si ottiene un errore come  'Internal Server Error' oppure vi mostra la schermata iniziale di odoo nella creazione del db e da qui vi dice che il db è già esistente dovete fare le seguenti cose:

### Errore 500 - Internal Server Error

1. Alcuni paramentri presenti all'interno o dell'odoo.conf o del docker-compose.yml puntano o al db sbagliato o al path errato, verificare e correggerli e successivamente lanciare i comandi

```
docker-compose down
docker-compose up -d
```
per ripristinare i container correttamente.

### Nome DB già esistente

2. In questo caso se appare il seguente messaggio vuol dire che vi è rimasto in memoria la vecchia struttura del db e quindi va eliminata altrimenti potete creare un nuovo db in quella maschera ed in fase di login swithcare database e rimettere quello inserito nel docker-compose.yml o nel odoo.conf.

# COMANDI GIT - PER UN CORRETTO UTILIZZO

## Aggiorniamo il nostro repository e swtch ramo
Come prima cosa è importante aggiornare il repository locale utilizzando:

```
git fetch
git checkout 'nomermo'
```
e successivamente passare al ramo desiderato.

## Se il ramo non esiste localmente

Se il ramo non esiste in locale ma solo su remoto puoi eseguire:

```
git checkout -b 'nomeramo' origin/nomeramo
```

## Mettere a pari il nuovo/vecchio ramo con il ramo principale

Ci sono due modi: <b>merge</b> o <b>rebase</b>.

### 1. Merge (più sicuro e mantiene la cronologia)
 Questo porterà nel ramo 'nomeramo' tutti i cambiamenti del ramo master, creando eventualmente un commit di merge.

 ```
git merge master
```

### 2. Rebase (più pulito, ma attenzione ai conflitti)
Questo "rigioca" i commit di 'nomeramo' sopra a master. Può richiedere di risolvere conflitti uno a uno se ci sono divergenze.

```
git rebase master
```

### 3. (Facoltativo) Spingere le modifiche aggiornare su remoto
Se vuoi aggiornare il ramo 'nomeramo' sul repository remoto dopo il merge o rebase:

```
git push origin 'nomeramo'
```

⚠️ Se hai fatto un rebase, potresti dover forzare il push:

```
git push --force origin 'nomeramo'
```

## Riassunto comandi

```
# 1. Vai nel ramo
git checkout 'nomeramo'          # o git checkout -b 'nomeramo' origin/nomeramo

# 2. Porta i cambiamenti da master (scegli una delle due righe)
git merge master                 # o git rebase master

# 3. Push se vuoi aggiornare il ramo remoto
git push origin 'nomeramo'      # o git push --force origin 'nomeramo' se hai fatto rebase

```

# BACKUP E RESTORE DATI

Per fare il backup dei dati completi lanciare:
```
docker exec -t celiani_db pg_dump -U celiani_superuser celianidb > backup.sql

```
mentre per fare il restore dei dati lanciare:
```
Get-Content .\backup.sql | docker exec -i celiani_db psql -U celiani_superuser -d celianidb

```

## ⚠️NOTA BENE
Entrambi i comandi vanno lanciati quando il servizio di celiani-odoo è stoppato e celiani_db sempre attivo
```
docker-compose stop odoo
// lanci lo script di restore o backup
docker-compose start odoo
```