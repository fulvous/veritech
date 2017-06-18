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

ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

#if [ -f /etc/lsb-release ]; then
#    . /etc/lsb-release
#    export OS=$DISTRIB_ID
#    export VER=$DISTRIB_RELEASE
#elif [ -f /etc/debian_version ]; then
if [ -f /etc/debian_version ]; then
    OS=debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
    OS=redhat
    VER=$(cat /etc/redhat-release | egrep -o '[0-9\.]+')
fi

supported_platform () {
  if [ "${OS}" != "debian" ] && [ "${OS}" != "redhat" ] ; then
    SUPPORTED=false
  fi

  if [ "${OS}" == "redhat" ] ; then
    case "${VER}" in
      "7") SUPPORTED=true
        ;;
      *) SUPPORTED=false
        ;;
    esac
  fi
}
