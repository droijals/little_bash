#####
#
# Aquest script el que fa és fer un ssh a cada server definit a l'array de la variable
# farm_hosts, i des de dins de cada contenidor lxc fa un ssh a cadascun dels diferents
# contenidors (LXC) que siguin del tipus tomate (fake name obviosuly) i no siguin templates i restarteja
# el supervisor. Es pot modificar per connectar-se i executar qualsevol altre tipus 
# de tasca en aquests contenidors, obviament.
#
#####


#!/bin/bash

# Our hosts to visit
farm_hosts=(lxc-host01.your_company_domain lxc-host02.your_company_domain lxc-host03.your_company_domain ...n)

for server in ${farm_hosts[@]}; do

# Un cop dins de cada host, un altre bucle per visitar tots els contenidors (lxc) que tingui dins del tipus tomate i restarteja el supervisor
  for container in `ssh root@$server "lxc-ls --fancy" | grep tomate | egrep -v template | awk '{print $1}'`; do
    ssh root@$server.your_company_domain "lxc-attach -n $container -- service supervisor restart"
    echo $server ":" $container
  done

done
