FROM odoo:18

# Copia lo script entrypoint con i permessi corretti
COPY --chmod=755 entrypoint.sh /entrypoint.sh