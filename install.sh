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
            cp ${GUEST_PATH}WEBOBS.rc /etc/webobs.d/WEBOBS.rc
            #rm -r ${GUEST_PATH}etopo.zip
            echo "Webobs Setup Ended..."
            pause 'Press [Enter] key to continue...'
            # /etc/init.d/apache2 restart
            systemctl enable apache2
            echo "Enabled Apache..."
            # /lib/systemd/systemd
            # echo "Initialised Systemd..."
            pause 'Press [Enter] key to continue...'
            runuser -l vagrant -c 'mkdir -p  ~/.config/systemd/user/'
            cp /opt/webobs/${WEBOBS}/SETUP/systemd/wo* /etc/systemd/system/
            #cp /opt/webobs/${WEBOBS}/SETUP/systemd/wo* /home/vagrant/.config/systemd/user/
            systemctl daemon-reload
            echo "Copied To Systemd..."
            pause 'Press [Enter] key to continue...'
            # /etc/init.d/dbus start
            chown vagrant:vagrant -R /home/vagrant/.config/systemd/user/
            chown vagrant:vagrant -R /opt/webobs/
            systemctl enable woscheduler.service
            systemctl enable wopostboard.service
            #runuser -l vagrant -c 'systemctl --user enable --now woscheduler.service'
            #runuser -l vagrant -c 'systemctl --user enable --now wopostboard.service'
            #runuser -l vagrant -c 'systemctl --user daemon-reload'
            echo "Enabled Systemd Services..."
            pause 'Press [Enter] key to continue...'
            a2dissite 000-default.conf
            systemctl reload apache2
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
      echo "Install succeded. The machine will shutdown now..."
      echo "To use Webobs restart the machine with <vagrant up>"
      echo "After restart Webobs will be available on http://localhost:9977"
      pause 'Press [Enter] key to continue...'
      shutdown -h now
fi

exec "$@"
