#!/bin/bash

# Leon Ramos
# leon.ramos@creadoresdigitales.com
# 2017

#    Este programa es software libre: Usted puede redistribuirlo y/o modificarlo
#    bajo los terminos de la licencia de uso publico general (GNU General Public License) como
#    aparece publicada por la Fundacion de Software Libre, ya sea la version 3 de dicha licencia, o
#    a su discresion, cualquier version posterior.

#    Este programa es distribuido con el objetivo de ser útil, pero sin ninguna garantia,
#    inclusive sin las garantias implicitas en la comercializacion o adecuadas para cualquier proposito especifico.
#    Vea la licencia de uso publico general "GNU General Public License" para mas detalles.

#    Si no recibe una copia de la licencia "GNU General Public License" junto con este codigo,
#    favor de referirse a la siguiente direccion: <http://www.gnu.org/licenses/>.

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


get_vars_file () {
  FILE=0
  while [ "$FILE" == "0" ] && [ "$FILE" != "" ] ; do
    FILE=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_vars_file_title' )" \
            --fselect ${VARS}  \
            $SY $SX  )
    if [ "$?" == "1" ] ; then
      exit 0
    fi
  done
  
  #source $FILE

}


check_prefix () {
  TEMP=$( echo "$1" | egrep -c "\b[a-zA-Z0-9]+\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --backtitle "$BACK_TITLE" \
            --title "$( echoP 'wrong_data_title')" \
            --msgbox "$( echoP 'wrong_prefix')" \
            $SY $SX
    IS_PREFIX=0
  else
    IS_PREFIX=1
  fi
}


get_prefix () {
  OPT=0
  IS_PREFIX=0
  while [ "$IS_PREFIX" == "0" ] ; do
    OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_prefix_title' )" \
            --inputbox "$( echoP 'get_prefix_content')" \
            $SY $SX "$( echoP 'prefix'  )" )
    if [ "$?" == "1" ] ; then
      exit 0
    fi
    check_prefix "$OPT"
  done

  PREFIX=$OPT
}

get_network () {
  SERVER_CONFIG_FILE="/etc/openvpn/server.conf"
  if [ ! -e $SERVER_CONFIG_FILE ] ; then
     $DIALOG --backtitle "$BACK_TITLE" \
            --title "$( echoP 'wrong_data_title')" \
            --msgbox "$( echoP 'wrong_file_not_found')" \
            $SY $SX
  fi

  NET_MASK=$( cat $SERVER_CONFIG_FILE | \
  egrep -o "[ ]*ifconfig[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}" | \
  egrep -o "[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}[ ]*$" | \
  egrep -o "[^ ]+"  )
  

  NET_FIRST=$( cat $SERVER_CONFIG_FILE | \
  egrep -o "[ ]*ifconfig-pool[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}" | \
  egrep -o "[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}[ ]+" | \
  egrep -o "[^ ]+"  )

  

  NET_LAST=$( cat $SERVER_CONFIG_FILE | \
  egrep -o "[ ]*ifconfig-pool[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}" | \
  egrep -o "[ ]+([0-9]{1,3}\.){3}[0-9]{1,3}$" | \
  egrep -o "[^ ]+"  )

  NET_DIG_FIRST=$( echo $NET_FIRST | egrep -o '[0-9]{1,3}$' )

  NET_DIG_LAST=$( echo $NET_LAST | egrep -o '[0-9]{1,3}$' )

  NET_PREFIX=$( echo $NET_FIRST | egrep -o '([0-9]{1,3}\.){3}' ) 

  #$DIALOG --backtitle "$BACK_TITLE" \
  #        --title "$( echoP 'net_prefix_title')" \
  #        --msgbox "$( echoP 'net_prefix_content') ${NET_FIRST} ${NET_LAST} ${NET_PREFIX}0 ${NET_DIG_FIRST} ${NET_DIG_LAST} " \
  #        $SY $SX
}

create_net_file () {
  > ${NET_FILE}
  for ip in $( seq $NET_DIG_FIRST $NET_DIG_LAST ) ; do
    echo $ip >> ${NET_FILE}
  done
}

select_ip () {
  NET_FILE="/etc/openvpn/net_file"
  if [ ! -e ${NET_FILE} ] ; then
    create_net_file
  fi
  
  declare -a IPS
  i=0
  for IP in $( cat ${NET_FILE} ) ; do
    IPS[$i]=$IP
    i=$(( $i + 1 ))
  done

  IP_LIST=""
  if [ ${#IPS[@]} -gt 20 ] ; then
    MAX_IP=20
  else
    MAX_IP=${#IPS[@]}
  fi

  for j in $( seq 1 ${MAX_IP} ) ; do
    #j=$(( i - 1 ))
    IP_LIST="$IP_LIST $j \"${NET_PREFIX}${IPS[$j]}\""
  done
  
  OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
          --title "$( echoP 'select_ip_title' )" \
          --menu "$( echoP 'select_ip_content') ${MAX_IP}" \
          $SY $SX ${MAX_IP} ${IP_LIST} )

  #NEW_INDEX=$(( $OPT - 1 ))
  NEW_INDEX=$OPT

  SELECTED_IP=${IPS[$NEW_INDEX]}
}

create_client_key () {
  cd $NEW_EASY
  #get_vars_file
  #export KEY_CN="${PREFIX}_${SELECTED_IP}"
  ./easyrsa --batch build-client-full ${PREFIX}_${SELECTED_IP} nopass
  echo "ifconfig-push ${NET_PREFIX}${SELECTED_IP} ${NET_MASK}" > ${CCD}/${PREFIX}_${SELECTED_IP}
  cd $CURR_DIR
  sleep 5
}

delete_selected () {
  cp ${NET_FILE} ${NET_TMP}
  cat ${NET_TMP} | egrep -v "^${SELECTED_IP}$" > ${NET_FILE}
}

ovpn_config () {

if [ ! -f $CURR_DIR/data/values/server_device ] ; then
    $DIALOG --backtitle "$BACK_TITLE" \
            --title "$( echoP 'wrong_data_title')" \
            --msgbox "$( echoP 'wrong_file_not_found') $CURR_DIR/data/values/server_device" \
            $SY $SX
fi

  BRAND="ovpn"
  OVPN="config.ovpn"
  if [ ! -d ${CONFIG}/${PREFIX}_${SELECTED_IP}/keys ] ; then
    mkdir -p ${CONFIG}/${PREFIX}_${SELECTED_IP}/keys
    mkdir -p ${CONFIG}/${PREFIX}_${SELECTED_IP}/${BRAND}
  fi
  cp ${NEW_EASY}pki/issued/${PREFIX}_${SELECTED_IP}.* ${CONFIG}/${PREFIX}_${SELECTED_IP}/keys
  cp ${NEW_EASY}pki/private/${PREFIX}_${SELECTED_IP}.* ${CONFIG}/${PREFIX}_${SELECTED_IP}/keys
  cp ${NEW_EASY}pki/ca.crt ${CONFIG}/${PREFIX}_${SELECTED_IP}/keys
  cp ${CONFIG}/${PREFIX}_${SELECTED_IP}/keys/* ${CONFIG}/${PREFIX}_${SELECTED_IP}/${BRAND}

  SERVER_NAME=$( cat $CURR_DIR/data/values/server_name )
  SERVER_PORT=$( cat $CURR_DIR/data/values/server_port | egrep -o '[0-9]+[ ]*$' )

cat << EOT > ${CONFIG}/${PREFIX}_${SELECTED_IP}/${BRAND}/${OVPN}
client
resolv-retry infinite
nobind
persist-key
persist-tun
mute-replay-warnings
ca ca.crt
comp-lzo
verb 3
ns-cert-type server
EOT

  cat $CURR_DIR/data/values/server_device >> ${CONFIG}/${PREFIX}_${SELECTED_IP}/${BRAND}/${OVPN}
  cat $CURR_DIR/data/values/server_protocol >> ${CONFIG}/${PREFIX}_${SELECTED_IP}/${BRAND}/${OVPN}
  echo "remote $SERVER_NAME $SERVER_PORT" >> ${CONFIG}/${PREFIX}_${SELECTED_IP}/${BRAND}/${OVPN}
  echo "cert ${PREFIX}_${SELECTED_IP}.crt" >> ${CONFIG}/${PREFIX}_${SELECTED_IP}/${BRAND}/${OVPN}
  echo "key ${PREFIX}_${SELECTED_IP}.key" >> ${CONFIG}/${PREFIX}_${SELECTED_IP}/${BRAND}/${OVPN}

  cd ${CONFIG}/${PREFIX}_${SELECTED_IP}/$BRAND
  zip ../${PREFIX}_${SELECTED_IP}_$BRAND.zip $OVPN ca.crt ${PREFIX}_${SELECTED_IP}.*

  cd $CURR_DIR
}
