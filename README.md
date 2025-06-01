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