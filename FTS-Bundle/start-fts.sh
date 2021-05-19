echo "###########################"
echo "Preparing"
echo "###########################"

#Touch
#Create log folders
echo "Create logs folder"
mkdir -p /data/logs/supervisor
mkdir -p /data/database
mkdir -p /data/certs/ClientPackages
echo "Set permissions on data folder"
chmod -R 777 /data

#Setting variables:
echo "Running FTS variable script"
source fts.sh
echo "Running UI variable script"
source ui.sh
echo "Running map variable script"
source map.sh

echo "###########################"
echo "Preparations completed"
echo "###########################"


supervisord -c /etc/supervisor/conf.d/supervisord.conf
