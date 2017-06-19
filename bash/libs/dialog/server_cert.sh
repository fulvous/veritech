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

KEY_LIST="(KEY_COUNTRY|KEY_PROVINCE|KEY_CITY|KEY_ORG|KEY_EMAIL|KEY_SIZE|KEY_OU)"

VALUES="data/values"

build_server_cert () {
  
  echo 0 | $DIALOG  --backtitle "${BACK_TITLE}" \
                    --title "server_cert_title" \
                    --gauge "$( echoP 'server_cert_content' )" \
                    ${SY} ${SX}

  if [ "$OS" == "redhat" ] ; then

    NEW_EASY="/etc/openvpn/easy-rsa/"
    VARS="${NEW_EASY}vars"
    egrep -v "$KEY_LIST" ./data/backup/vars > $VARS
    echo "export KEY_COUNTRY=\"$(cat $VALUES/cert_country)\"" >> $VARS
    echo "export KEY_PROVINCE=\"$(cat $VALUES/cert_province)\"" >> $VARS
    echo "export KEY_CITY=\"$(cat $VALUES/cert_city)\"" >> $VARS
    echo "export KEY_ORG=\"$(cat $VALUES/cert_organization)\"" >> $VARS
    echo "export KEY_EMAIL=\"$(cat $VALUES/cert_email)\"" >> $VARS
    echo "export KEY_EMAIL=$(cat $VALUES/cert_email)" >> $VARS
    echo "export KEY_SIZE=\"$(cat $VALUES/server_key_size)\"" >> $VARS
    echo 10 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}
    
    OLD_DIR=$(pwd)
    cd ${NEW_EASY}
    source ./vars && ./clean-all
    echo 40 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}
  
    export EASY_RSA="${EASY_RSA:-.}"
    "$EASY_RSA/pkitool" --initca $*
    echo 60 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}
    
    export EASY_RSA="${EASY_RSA:-.}"
    "$EASY_RSA/pkitool" --server $(cat $OLD_DIR/$VALUES/server_name)
    echo 80 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}

    ./build-dh
    echo 100 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}
    cd ${OLD_DIR}
    

  elif [ "$OS" == "debian" ] ; then

    NEW_EASY="/etc/openvpn/easy-rsa/"
    VARS="${NEW_EASY}vars"
    egrep -v "$KEY_LIST" ./data/backup/vars > $VARS
    echo "export KEY_COUNTRY=\"$(cat $VALUES/cert_country)\"" >> $VARS
    echo "export KEY_PROVINCE=\"$(cat $VALUES/cert_province)\"" >> $VARS
    echo "export KEY_CITY=\"$(cat $VALUES/cert_city)\"" >> $VARS
    echo "export KEY_ORG=\"$(cat $VALUES/cert_organization)\"" >> $VARS
    echo "export KEY_EMAIL=\"$(cat $VALUES/cert_email)\"" >> $VARS
    echo "export KEY_EMAIL=$(cat $VALUES/cert_email)" >> $VARS
    echo "export KEY_SIZE=\"$(cat $VALUES/server_key_size)\"" >> $VARS
    echo 10 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}
    
    OLD_DIR=$(pwd)
    cd ${NEW_EASY}
    source ./vars && ./clean-all
    echo 40 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}
  
    export EASY_RSA="${EASY_RSA:-.}"
    "$EASY_RSA/pkitool" --initca $*
    echo 60 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}
    
    export EASY_RSA="${EASY_RSA:-.}"
    "$EASY_RSA/pkitool" --server $(cat $OLD_DIR/$VALUES/server_name)
    echo 80 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}

    ./build-dh
    echo 100 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "server_cert_title" \
                      --gauge "$( echoP 'server_cert_content' )" \
                      ${SY} ${SX}
    cd ${OLD_DIR}

     
  fi
}
