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
check_ou () {
  TEMP=$( echo "$1" | egrep -c "\b[a-zA-Z0-9\s.-]+\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --title "$( echoP 'wrong_data_title')" --msgbox "$( echoP 'wrong_ou')" $SY $SX
    IS_OU=0
  else
    IS_OU=1
  fi
}


get_ou () {
  OPT=0
  IS_OU=0
  while [ "$IS_OU" == "0" ] ; do
    OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_ou_title')" \
            --inputbox "$( echoP 'get_ou_content')" \
            $SY $SY "$( echoP 'your_ou')" )
    if [ "$?" == "1" ] ; then
      exit 0
    fi
    check_ou "$OPT"
  done
  
  CERT_OU=$OPT
  mkdir -p ./data/values
  echo "$CERT_OU" > ./data/values/cert_ou
}


get_country () {
  old_IFS=${IFS}
  IFS=","
  
  declare -a countriesTag
  declare -a countriesCode
  while read -r -a array 
  do 
    countriesTag["${array[0]}"]="${array[1]}-${array[2]}"
    countriesCode["${array[0]}"]="${array[2]}"
  done < $COUNTRIES
  IFS=${old_IFS}
  
  OPTIONS=""
  for key in "${!countriesTag[@]}"
  do
    OPTIONS="$OPTIONS  ${key} ${countriesTag[${key}]}"
  done

  OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_country_title')" \
            --default-item 144 \
            --menu "$( echoP 'get_country_content')" \
            $SY $SX 9 \
      $OPTIONS )

  if [ "$?" == "1" ] ; then
    exit 0
  fi

  OPT2=${countriesCode[${OPT}]}
  CERT_COUNTRY=$OPT2
  mkdir -p ./data/values
  echo "$CERT_COUNTRY" > ./data/values/cert_country
}

check_province () {
  TEMP=$( echo "$1" | egrep -c "\b[a-zA-Z0-9\s.-]+\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --title "$( echoP 'wrong_data_title')" --msgbox "$( echoP 'wrong_province')" $SY $SX
    IS_PROVINCE=0
  else
    IS_PROVINCE=1
  fi
}


get_province () {
  OPT=0
  IS_PROVINCE=0
  while [ "$IS_OU" == "0" ] ; do
    OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_province_title')" \
            --inputbox "$( echoP 'get_province_content')" \
            $SY $SX "$( echoP 'your_province')" )
    if [ "$?" == "1" ] ; then
      exit 0
    fi
    check_province "$OPT"
  done
  
  CERT_PROVINCE=$OPT
  mkdir -p ./data/values
  echo "$CERT_PROVINCE" > ./data/values/cert_province
}

check_city () {
  TEMP=$( echo "$1" | egrep -c "\b[a-zA-Z0-9\s.-]+\b" )
  if [ $TEMP -ne 1 ] ; then
    $DIALOG --title "$( echoP 'wrong_data_title')" --msgbox "$( echoP 'wrong_city')" $SY $SX
    IS_CITY=0
  else
    IS_CITY=1
  fi
}


get_city () {
  OPT=0
  IS_CITY=0
  while [ "$IS_CITY" == "0" ] ; do
    OPT=$( $DIALOG --stdout --backtitle "$BACK_TITLE" \
            --title "$( echoP 'get_city_title')" \
            --inputbox "$( echoP 'get_city_content')" \
            $SY $SX "$( echoP 'your_city')" )
    if [ "$?" == "1" ] ; then
      exit 0
    fi
    check_city "$OPT"
  done
  
  CERT_CITY=$OPT
  mkdir -p ./data/values
  echo "$CERT_CITY" > ./data/values/cert_city
}
