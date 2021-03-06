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

setup_easy-rsa () {
  
  echo 0 | $DIALOG  --backtitle "${BACK_TITLE}" \
                    --title "$(echoP 'easy-rsa_title')" \
                    --gauge "$(echoP 'easy-rsa_content')" \
                    ${SY} ${SX}
  sleep 0.5

  if [ "$OS" == "redhat" ] ; then

    EASY_RSA="/usr/share/easy-rsa/2.0/*"
    NEW_EASY="/etc/openvpn/easy-rsa/"
    mkdir -p ${NEW_EASY}
    mkdir -p $CURR_DIR/data/backup
    echo 30 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'easy-rsa_title')" \
                      --gauge "$( echoP 'easy-rsa_content' )" \
                      ${SY} ${SX}
    sleep 0.5
    cp -afv ${EASY_RSA} ${NEW_EASY} 
    echo 60 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'easy-rsa_title')" \
                      --gauge "$( echoP 'easy-rsa_content' )" \
                      ${SY} ${SX}
    sleep 0.5
    cp -af /etc/openvpn/easy-rsa/vars $CURR_DIR/data/backup/vars   
    egrep -v "$KEY_LIST" $CURR_DIR/data/backup/vars > /etc/openvpn/easy-rsa/vars
    echo 100 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'easy-rsa_title')" \
                      --gauge "$( echoP 'easy-rsa_content' )" \
                      ${SY} ${SX}
    sleep 0.5

  elif [ "$OS" == "debian" ] ; then

    #EASY_RSA="/usr/share/easy-rsa/*"    
    NEW_EASY="/etc/openvpn/easy-rsa/"
    rmdir -Rf ${NEW_EASY}
    mkdir -p $CURR_DIR/data/backup
    echo 30 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'easy-rsa_title')" \
                      --gauge "$( echoP 'easy-rsa_content' )" \
                      ${SY} ${SX}
    sleep 0.5
    #cp -afv ${EASY_RSA} ${NEW_EASY}
    make-cadir ${NEW_EASY}
    echo 60 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'easy-rsa_title')" \
                      --gauge "$( echoP 'easy-rsa_content' )" \
                      ${SY} ${SX}
    sleep 0.5
    cp -af /etc/openvpn/easy-rsa/vars $CURR_DIR/data/backup/vars   
    egrep -v "$KEY_LIST" $CURR_DIR/data/backup/vars > /etc/openvpn/easy-rsa/vars
    echo 100 | $DIALOG  --backtitle "${BACK_TITLE}" \
                      --title "$(echoP 'easy-rsa_title')" \
                      --gauge "$( echoP 'easy-rsa_content' )" \
                      ${SY} ${SX}
    sleep 0.5


  fi



}
