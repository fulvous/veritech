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
  echo "$SERVER_PROTOCOL" > ./data/values/server_protocol
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
  echo "$SERVER_PORT" > ./data/values/server_port
}
