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

create_ca () {
  setup_easy-rsa
  DATA_OK="false"
  while [ "$DATA_OK" == "false" ] ; do
    get_server
    get_key_size
    get_ou
    get_country
    get_province
    get_city
    get_organization
    get_email
    validate_cert
  done
  build_server_cert
}

create_server_conf () {
  DATA_OK="false" 
  while [ "$DATA_OK" == "false" ] ; do
    get_protocol
    get_port
    get_server_pool
    get_device
    get_dns
    get_gateway
    validate_server_config
  done
  build_server_config
}

erase_server_cert () {
  rm -Rf /etc/openvpn/easy-rsa > /dev/null 2>&1
}

create_client_cert () {
  DATA_OK="false"
  while [ "$DATA_OK" == "false" ] ; do
    get_prefix
    get_network
    select_ip
    create_client_key
    delete_selected
    ovpn_config
    DATA_OK="true"
  done

}
