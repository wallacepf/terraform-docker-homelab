#!/bin/bash

if ! command -v psql &> /dev/null; then
    echo "Erro: O cliente PostgreSQL não está instalado. Por favor, instale o cliente PostgreSQL."
    exit 1
fi

while true; do
    PGPASSWORD=$DB_PASS psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "SELECT 1;" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Conexão bem-sucedida ao banco de dados PostgreSQL!"
        break
    else
        echo "Tentando conectar ao banco de dados PostgreSQL..."
        sleep 5
    fi
done


while true; do
    sleep 3600
done
