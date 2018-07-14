#####
#
# Thx to my big boss MMG for helping me this time! :)
#
# Aquest script es troba a un dels jenkins de "la casa" (...) i el que fa és
# estalviar feina, des d'allà fa un ssh a cada lxc-host definit a la variable
# farm_hosts, i des de dins de cada lxc-host fa un ssh a cadascun dels diferents
# contenidors que siguin del tipus tomate (fake name obviosuly) i restarteja
# el supervisor. Es pot modificar per connectar-se i executar qualsevol altre tipus 
# de tasca, obviament.
#
#####


#!/bin/bash

# Our hosts to visit
farm_hosts=(lxc-host01 lxc-host02 lxc-host03 lxc-host04 lxc-host05 lxc-host...n)

for server in ${farm_hosts[@]}; do

# Un cop dins de cada host, un altre bucle per visitar tots els contenidors (lxc) que tingui dins del tipus tomate i restarteja el supervisor
  for container in `ssh root@$server.your_company_domain "lxc-ls --fancy" | grep tomate | egrep -v template | awk '{print $1}'`; do
    ssh root@$server.your_company_domain "lxc-attach -n $container -- service supervisor restart"
    echo $server ":" $container
  done

done
