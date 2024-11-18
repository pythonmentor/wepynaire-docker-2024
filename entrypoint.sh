#!/bin/bash
 
# Arrêter le script en cas 
# d'erreur ou de variable
# non définie
set -o errexit
set -o pipefail
set -o nounset

# Attendre que la base de données soit prête
echo "Waiting for database..."
wait-for-it "$POSTGRES_HOST:$POSTGRES_PORT" --timeout=35
 
# Appliquer les migrations
echo "Applying database migrations..."
python manage.py migrate --noinput
 
# Lancer le serveur Django
echo "Starting Django server..."
exec "$@"