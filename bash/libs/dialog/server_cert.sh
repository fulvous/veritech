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

#KEY_LIST="(KEY_COUNTRY|KEY_PROVINCE|KEY_CITY|KEY_ORG|KEY_EMAIL|KEY_SIZE|KEY_OU)"
KEY_LIST="(EASYRSA_REQ_COUNTRY|EASYRSA_REQ_PROVINCE|EASYRSA_REQ_CITY|EASYRSA_REQ_ORG|EASYRSA_REQ_EMAIL|EASYRSA_REQ_OU|EASYRSA_KEY_SIZE|EASYRSA_REQ_CN|EASYRSA_BATCH)"


VALUES="$CURR_DIR/data/values"

build_server_cert () {

  echo 0 | $DIALOG  --backtitle "${BACK_TITLE}" \
                    --title "$(echoP 'server_cert_title')" \
                    --gauge "$(echoP 'server_cert_content')" \
                    ${SY} ${SX}

  if [ "$OS" == "redhat" ] ; then

    egrep -v "$KEY_LIST" $CURR_DIR/data/backup/vars > $VARS
    echo "set_var EASYRSA_REQ_COUNTRY=\"$(cat $VALUES/cert_country)\"" >> $VARS
    echo "set_var EASYRSA_REQ_PROVINCE=\"$(cat $VALUES/cert_province)\"" >> $VARS
    echo "set_var EASYRSA_REQ_CITY=\"$(cat $VALUES/cert_city)\"" >> $VARS
    echo "set_var EASYRSA_REQ_ORG=\"$(cat $VALUES/cert_organization)\"" >> $VARS
    echo "set_var EASYRSA_REQ_EMAIL=\"$(cat $VALUES/cert_email)\"" >> $VARS
    echo "set_var EASYRSA_REQ_OU=\"$(cat $VALUES/cert_ou)\"" >> $VARS
    echo "set_var EASYRSA_KEY_SIZE=\"$(cat $VALUES/server_key_size)\"" >> $VARS
    echo "set_var EASYRSA_REQ_CN=\"$(cat $VALUES/server_name)\"" >> $VARS
    echo "set_var EASYRSA_BATCH=\"yes\"" >> $VARS
    echo 10 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}
    
    cd ${NEW_EASY}
    source ./vars > /dev/null 2>&1
    ./clean-all > /dev/null 2>&1
    echo 40 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}
  
    export EASY_RSA="${EASY_RSA:-.}"
    "$EASY_RSA/pkitool" --initca $* > /dev/null 2>&1
    echo 60 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}
    
    export EASY_RSA="${EASY_RSA:-.}"
    "$EASY_RSA/pkitool" --server server > /dev/null 2>&1
    echo 80 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}

    ./build-dh > /dev/null 2>&1
    OUT=$?
    echo 100 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content' )" \
                      ${SY} ${SX}
    cd ${CURR_DIR}
    if [ "$OUT" == "0" ] ; then
      $DIALOG --backtitle "${BACK_TITLE}" \
        --title "$(echoP 'server_cert_title')" \
        --msgbox "$(echoP 'server_cert_successful')" \
        $SY $SX
    fi
     

  elif [ "$OS" == "debian" ] ; then

    egrep -v "$KEY_LIST" $CURR_DIR/data/backup/vars > $VARS
    echo "set_var EASYRSA_REQ_COUNTRY \"$(cat $VALUES/cert_country)\"" >> $VARS
    echo "set_var EASYRSA_REQ_PROVINCE \"$(cat $VALUES/cert_province)\"" >> $VARS
    echo "set_var EASYRSA_REQ_CITY \"$(cat $VALUES/cert_city)\"" >> $VARS
    echo "set_var EASYRSA_REQ_ORG \"$(cat $VALUES/cert_organization)\"" >> $VARS
    echo "set_var EASYRSA_REQ_EMAIL \"$(cat $VALUES/cert_email)\"" >> $VARS
    echo "set_var EASYRSA_REQ_OU \"$(cat $VALUES/cert_ou)\"" >> $VARS
    echo "set_var EASYRSA_KEY_SIZE $(cat $VALUES/server_key_size)" >> $VARS
    echo "set_var EASYRSA_REQ_CN \"$(cat $VALUES/server_name)\"" >> $VARS
    echo "set_var EASYRSA_BATCH \"yes\"" >> $VARS

    echo 10 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}

    rm -Rf ${NEW_EASY}
    make-cadir ${NEW_EASY}
    cd ${NEW_EASY}
    sed 's/^RANDFILE.*ENV/#&/' openssl-easyrsa.cnf > openssl-easyrsa.cnf.new
    cp -f openssl-easyrsa.cnf.new openssl-easyrsa.cnf
    rm -f openssl-easyrsa.cnf.new
    ./easyrsa --batch init-pki > /dev/null 2>&1
    echo 40 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}
  
    ./easyrsa --batch build-ca nopass > /dev/null 2>&1
    echo 60 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}
    
    ./easyrsa --batch gen-req "$(cat $VALUES/server_name)" nopass && 
      ./easyrsa --batch sign-req server "$(cat $VALUES/server_name)" > /dev/null 2>&1
    echo 80 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}

    ./easyrsa --batch gen-dh > /dev/null 2>&1
    OUT=$?
    echo 100 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'server_cert_title')" \
                      --gauge "$(echoP 'server_cert_content')" \
                      ${SY} ${SX}
    cd ${CURR_DIR}
    if [ "$OUT" == "0" ] ; then
      $DIALOG --backtitle "${BACK_TITLE}" \
        --title "$(echoP 'server_cert_title')" \
        --msgbox "$(echoP 'server_cert_successful')" \
        $SY $SX
    fi

  fi
}
