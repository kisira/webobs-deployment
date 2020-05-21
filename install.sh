#!/bin/bash
set -e

function pause(){
   read -p "$*"
}

if [ -z "$WEBOBS" ]
then
      echo "\$WEBOBS is empty"
else
      var=0
      curr=0
      LOCKFILE=lock.txt
      if [ -e ~/${LOCKFILE} ]
      then
            curr=`cat ~/${LOCKFILE}`
      else
            echo $var > ~/${LOCKFILE}
      fi
      if [[ $var -eq $curr ]]
      then
            pause 'Press [Enter] key to continue...'
            echo "$WEBOBS Setup Is Starting"
            pause 'Press [Enter] key to continue...'
            /opt/webobs/${WEBOBS}/SETUP/setup  --force
            echo "Copy WEBOBS.rc..."
            #ETOPO5
            #Actual folder is -- /opt/webobs/DATA/DEM/ETOPO
            unzip -d /opt/webobs/DATA/DEM/ETOPO ${GUEST_PATH}etopo.zip
            mv ${GUEST_PATH}WEBOBS.rc /etc/webobs.d/WEBOBS.rc
            rm -r ${GUEST_PATH}etopo.zip
            echo "Webobs Setup Ended..."
            pause 'Press [Enter] key to continue...'
            # /etc/init.d/apache2 restart
            systemctl enable apache2
            echo "Enabled Apache..."
            # /lib/systemd/systemd
            # echo "Initialised Systemd..."
            pause 'Press [Enter] key to continue...'
            cp /opt/webobs/${WEBOBS}/SETUP/systemd/wo* /etc/systemd/system/
            echo "Copied To Systemd..."
            pause 'Press [Enter] key to continue...'
            systemctl enable woscheduler.service
            systemctl enable wopostboard.service
            echo "Enabled Systemd Services..."
            pause 'Press [Enter] key to continue...'
            #systemctl start woscheduler.service
            #systemctl start wopostboard.service
            echo "Started Systemd..."
            pause 'Press [Enter] key to continue...'
      else
            /lib/systemd/systemd
            echo "Initialised Systemd..."
      fi
      echo -n "" > ~/${LOCKFILE}
      curr=$((curr + 1))
      echo $curr
      pause 'Press [Enter] key to continue...'
      # exec sed -i '1s/^/$var/' ${LOCKFILE}
      echo $curr > ~/${LOCKFILE}
      echo "Locked..."
      pause 'Press [Enter] key to continue...'
fi

exec "$@"
