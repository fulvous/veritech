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

check_server () {
  TEMP=$( echo "$1" | egrep -c "\b[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --backtitle "$BACK_TITLE" \
            --title "$( echoP 'wrong_data_title')" \
            --msgbox "$( echoP 'wrong_server_address')" \
            $SY $SX
    IS_SERVER=0
  else
    IS_SERVER=1
  fi
}


get_server () {
  OPT=0
  IS_SERVER=0
  while [ "$IS_SERVER" == "0" ] ; do
    OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_server_title' )" \
            --inputbox "$( echoP 'get_server_content')" \
            $SY $SX "$( echoP 'your_server_name')" )
    if [ "$?" == "1" ] ; then
      exit 0
    fi
    check_server "$OPT"
  done

  SERVER_NAME=$OPT
  mkdir -p ./data/values
  echo "$SERVER_NAME" > ./data/values/server_name
}

get_protocol () {
  OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
          --title "$( echoP 'get_protocol_title' )" \
          --radiolist "$( echoP 'get_protocol_content')" \
          $SY $SX 2 \
          1 udp on \
          2 tcp off )
  if [ "$?" == "1" ] ; then
    exit 0
  fi

  case "$OPT" in
    "1") SERVER_PROTOCOL="udp"
      ;;
    "2") SERVER_PROTOCOL="tcp"
      ;;
  esac

  mkdir -p ./data/values
  echo "proto $SERVER_PROTOCOL" > ./data/values/server_protocol
}


get_device () {
  OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
          --title "$( echoP 'get_device_title' )" \
          --radiolist "$( echoP 'get_device_content')" \
          $SY $SX 2 \
          1 tun on \
          2 "tap bridge" off )
  if [ "$?" == "1" ] ; then
    exit 0
  fi

  case "$OPT" in
    "1") SERVER_DEVICE="tun"
      ;;
    "2") SERVER_DEVICE="tap"
      ;;
  esac

  mkdir -p ./data/values
  echo "dev $SERVER_DEVICE" > ./data/values/server_device
}



check_port () {
  TEMP=$( echo "$1" | egrep -c "\b[0-9]+\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --backtitle "$BACK_TITLE" \
            --title "$( echoP 'wrong_data_title')" \
            --msgbox "$( echoP 'wrong_port')" \
            $SY $SX
    IS_PORT=0
  else
    IS_PORT=1
  fi
}


get_port () {
  OPT=0
  IS_PORT=0
  while [ "$IS_PORT" == "0" ] ; do
    OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_port_title' )" \
            --inputbox "$( echoP 'get_port_content')" \
            $SY $SX "1194" )
    if [ "$?" == "1" ] ; then
      exit 0
    fi
    check_port "$OPT"
  done

  SERVER_PORT=$OPT
  mkdir -p ./data/values
  echo "port $SERVER_PORT" > ./data/values/server_port
}

get_key_size () {
  OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
          --title "$( echoP 'get_key_size_title' )" \
          --radiolist "$( echoP 'get_key_size_content')" \
          $SY $SX 5 \
          1 128 off \
          2 512 off \
          3 1024 off \
          4 2048 off \
          5 4096 on )
  if [ "$?" == "1" ] ; then
    exit 0
  fi

  case "$OPT" in
    "1") SERVER_KEY_SIZE="128"
      ;;
    "2") SERVER_KEY_SIZE="512"
      ;;
    "3") SERVER_KEY_SIZE="1024"
      ;;
    "4") SERVER_KEY_SIZE="2048"
      ;;
    "5") SERVER_KEY_SIZE="4096"
      ;;
  esac

  mkdir -p ./data/values
  echo "$SERVER_KEY_SIZE" > ./data/values/server_key_size
}

check_server_pool () {
  TEMP=$( echo "$1" | egrep -c "\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\s+[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\s+[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --backtitle "${BACK_TITLE}" \
     --title "$(echoP 'wrong_data_title')" \
     --msgbox "$(echoP 'wrong_server_net')" \
     $SY $SX
    IS_SERVER_POOL=0
  else
    IS_SERVER_POOL=1
  fi
}

get_server_pool () {
  OPT=0
  IS_SERVER_POOL=0
  while [ "$IS_SERVER_POOL" == "0" ] ; do
    OPT=$( $DIALOG --stdout --backtitle "${BACK_TITLE}" \
      --title "$(echoP 'get_server_net_title')" \
      --inputbox "$(echoP 'get_server_net_content')" \
      $SY $SX )
    if [ "$?" == "1" ] ; then
      exit 1
    fi
    check_server_pool "$OPT"
  done

  SERVER_POOL=$OPT 
  mkdir -p ./data/values
  echo "ifconfig-pool $SERVER_POOL" > ./data/values/server_pool

  SERVER_IP=$( echo ${SERVER_POOL} | egrep -o '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.' )
  SERVER_IP="${SERVER_IP}1"
  echo "$SERVER_IP" > ./data/values/server_ip
}

check_dns () {
  TEMP=$( echo "$1" | egrep -c "\b[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --backtitle "$BACK_TITLE" \
            --title "$( echoP 'wrong_data_title')" \
            --msgbox "$( echoP 'wrong_dns_address')" \
            $SY $SX
    IS_DNS=0
  else
    IS_DNS=1
  fi
}


get_dns () {
  OPT=0
  IS_DNS=0
  while [ "$IS_DNS" == "0" ] ; do
    OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_dns_title' )" \
            --inputbox "$( echoP 'get_dns_content')" \
            $SY $SX "$( echoP 'your_dns')" )
    if [ "$?" == "1" ] ; then
      exit 0
    fi
    check_dns "$OPT"
  done

  SERVER_DNS=$OPT
  mkdir -p ./data/values
  echo "push \"dhcp-option DNS $SERVER_DNS\"" > ./data/values/server_dns
}

get_gateway () {
  OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
          --title "$( echoP 'get_gateway_title' )" \
          --radiolist "$( echoP 'get_gateway_content')" \
          $SY $SX 2 \
          1 "$(echoP 'vpn_as_default_gateway')" on \
          2 "$(echoP 'add_static_routes')" off )
  if [ "$?" == "1" ] ; then
    exit 0
  fi

  case "$OPT" in
    "1") SERVER_GATEWAY="push \"route-gateway ${SERVER_IP}\""
      ;;
    "2") SERVER_GATEWAY=""
      get_static_route
      ;;
  esac

  mkdir -p ./data/values
  echo "$SERVER_GATEWAY" > ./data/values/server_gateway
}

check_static_route () {
  TEMP=$( echo "$1" | egrep -c "\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\s+[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --backtitle "${BACK_TITLE}" \
     --title "$(echoP 'wrong_data_title')" \
     --msgbox "$(echoP 'wrong_static_route')" \
     $SY $SX
    IS_STATIC_ROUTE=0
  else
    IS_STATIC_ROUTE=1
  fi
}

get_static_route () {
  ANOTHER=1
  FIRST_ROUTE=1
  while [ "${ANOTHER}" == "1" ] ; do
    OPT=0
    IS_STATIC_ROUTE=0
    while [ "$IS_STATIC_ROUTE" == "0" ] ; do
      OPT=$( $DIALOG --stdout --backtitle "${BACK_TITLE}" \
        --title "$(echoP 'get_static_route_title')" \
        --inputbox "$(echoP 'get_static_route_content')" \
        $SY $SX )
      if [ "$?" == "1" ] ; then
        exit 1
      fi
      check_static_route "$OPT"
    done

    SERVER_STATIC_ROUTE=$OPT 
    mkdir -p ./data/values
    if [ "${FIRST_ROUTE}" == "1" ] ; then
      echo "push \"route $SERVER_STATIC_ROUTE\"" > ./data/values/server_static_route
      SERVER_ROUTES="${SERVER_STATIC_ROUTE}"
      FIRST_ROUTE=0
    else
      SERVER_ROUTES="${SERVER_ROUTES}${SERVER_STATIC_ROUTE}"
      echo "push \"route $SERVER_STATIC_ROUTE\"" >> ./data/values/server_static_route
    fi

    $DIALOG --stdout --backtitle "${BACK_TITLE}" \
        --title "$(echoP 'get_another_route_title')" \
        --yesno "$(echoP 'get_another_route_content')" \
        $SY $SX
    if [ "$?" == "1" ] ; then
      ANOTHER="0"
    fi

  done

}

validate_server_config () {
  DATA="  $(echoP 'server_ip'): '$SERVER_IP'\n\
  $(echoP 'server_port'): '$SERVER_PORT'\n\
  $(echoP 'server_device'): '$SERVER_DEVICE'\n\
  $(echoP 'server_protocol'): '$SERVER_PROTOCOL'\n\
  $(echoP 'server_pool'): '$SERVER_POOL'\n\
  $(echoP 'server_dns'): '$SERVER_DNS'\n\
  $(echoP 'server_gateway'): '$SERVER_GATEWAY'\n\
  $(echoP 'server_routes'): '$SERVER_ROUTES'\n"
  $DIALOG --backtitle "$BACK_TITLE" \
    --title "$(echoP 'validate_title')" \
    --yesno "$(echoP 'validate_content'):\n\n${DATA}" \
    $SY $SX
  if [ "$?" == "0" ] ; then
    DATA_OK="true"
  fi
}

build_server_config () {
  KEYS_PATH="/etc/openvpn/easy-rsa/keys"
  SERVER_CONFIG_FILE="/etc/openvpn/server.conf"
  cat ./data/values/server_port > ${SERVER_CONFIG_FILE}
  cat ./data/values/server_protocol >> ${SERVER_CONFIG_FILE}
  cat ./data/values/server_device >> ${SERVER_CONFIG_FILE}
  echo "ca ${KEYS_PATH}/ca.crt" >> ${SERVER_CONFIG_FILE}
  echo "cert ${KEYS_PATH}/server.crt" >> ${SERVER_CONFIG_FILE}
  echo "key ${KEYS_PATH}/server.key" >> ${SERVER_CONFIG_FILE}
  echo "dh ${KEYS_PATH}/dh$(cat ./data/values/server_key_size).pem" >> ${SERVER_CONFIG_FILE}
  echo "topology subnet" >> ${SERVER_CONFIG_FILE}
  echo "push \"topology subnet\"" >> ${SERVER_CONFIG_FILE}
  cat ./data/values/server_static_route >> ${SERVER_CONFIG_FILE}
  cat ./data/values/server_gateway >> ${SERVER_CONFIG_FILE}
  cat ./data/values/server_pool >> ${SERVER_CONFIG_FILE}
  echo "client-config-dir /etc/openvpn/ccd" >> ${SERVER_CONFIG_FILE}
  cat ./data/values/server_dns >> ${SERVER_CONFIG_FILE}
  echo "keepalive 10 120" >> ${SERVER_CONFIG_FILE}
  echo "comp-lzo" >> ${SERVER_CONFIG_FILE}
  echo "status /var/log/openvpn.log" >> ${SERVER_CONFIG_FILE}
  echo "verb 3" >> ${SERVER_CONFIG_FILE}
  echo "explicit-exit-notify 1" >> ${SERVER_CONFIG_FILE}
}
