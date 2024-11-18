	
# Utiliser une image Python
FROM python:3.12
 
# Définir le répertoire de travail dans le conteneur
WORKDIR /app
 
# Empêcher Python d'écrire des fichiers pyc et de bufferiser les logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install --no-install-recommends -y \
    wait-for-it 
 
# Mettre à jour pip
RUN pip install --upgrade pip
 
# Copier le fichier de dépendances
COPY ./requirements.txt .
 
# Installer les dépendances
RUN pip install -r requirements.txt
 
# Copier le reste du code
COPY . .

COPY ./entrypoint.sh /entrypoint
	
# Donner les permissions d'exécution au script
RUN chmod +x /entrypoint

	
# Utiliser le script comme point d'entrée
ENTRYPOINT ["/entrypoint"]
 
# Commande par défaut pour lancer le serveur Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]