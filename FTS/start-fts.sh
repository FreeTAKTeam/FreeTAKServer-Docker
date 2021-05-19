echo "###########################"
echo "Preparing"
echo "###########################"

#Touch
#Create log folders
echo "Create logs folder"
mkdir -p /data/logs/supervisor
mkdir -p /data/database/
mkdir -p /data/certs/ClientPackages/
echo "Set permissions on data folder"
chmod -R 777 /data

#Setting variables:
echo "Running FTS variable script"
source fts.sh

echo "###########################"
echo "Preparations completed"
echo "###########################"

echo "Starting FTS"
python3 -m FreeTAKServer.controllers.services.FTS 