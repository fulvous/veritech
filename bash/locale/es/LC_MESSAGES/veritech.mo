��    Z      �     �     �     �     �     �     �     �  
             ,     =     L     R     d  	   i     s     �     �     �     �     �     �     �     	     	     -	     ?	     O	     c	     u	     �	     �	     �	     �	     �	     �	     �	     	
     
     1
     F
     Y
     l
     �
     �
     �
     �
     �
     �
       	             .     >     G     T     ]     q     �     �     �  	   �     �     �     �     �     �               /     @     O     f     v  
   �     �     �     �     �     �  
   �     �     �     	  	        $  
   -     8     J     R     `     q     �     �     �     �     �     �  6   �  }   ,     �     �  ,   �       *        2     O     \     |  "   �     �  )   �     �  C   �     -     9     Y  9   m     �  o   �     +  &   <     c     q     �  >   �     �  #   �  	     "     	   <  9   F  �   �            ?   ,     l     }     �     �     �  L   �  (     !   @     b  	   p  �   z  ^        {     �     �     �     �     �     �          *      =     ^  %   x     �     �  �   �  
   �  7   �     �  O   �  (   F  >   o  =   �  N   �  :   ;  g   v  Q   �  	   0     :     P     ]     n     w     �  P             2      H       #   %       	   -       ;           W          C      O       G   =   A   R                    0   E          S       M   1   '   5   !   /   
   3   *       L   V      @            ,   9           T      .             <   6       (   F      $               Q   Y           N   D                  7   X   B   8              J         >   )       U                                 "                 K          ?       &   :      I         4   +   Z   add_static_routes choose_action city country create_client_cert debug_current_platform department dialog_back_title easy-rsa_content easy-rsa_title email erase_server_cert exit first_run get_another_route_content get_another_route_title get_city_content get_city_title get_country_content get_country_title get_device_content get_device_title get_dns_content get_dns_title get_email_content get_email_title get_gateway_content get_gateway_title get_key_size_content get_key_size_title get_organization_content get_organization_title get_ou_content get_ou_title get_port_content get_port_title get_protocol_content get_protocol_title get_province_content get_province_title get_server_content get_server_net_content get_server_net_title get_server_title get_static_route_content get_static_route_title getopts_debug_enabled getopts_unknown_option key_size main_menu modify_server_config need_to_install not_root organization province server_cert_content server_cert_successful server_cert_title server_device server_gateway server_ip server_name server_pool server_port server_protocol server_routes unsupported_os_version unsupported_platform validate_content validate_title vpn_as_default_gateway welcome_content welcome_title wrong_city wrong_data_title wrong_dns_address wrong_email wrong_organization wrong_ou wrong_port wrong_province wrong_server_address wrong_server_net your_city your_dns your_email your_organization your_ou your_province your_server_name No, agrega rutas estáticas Seleccione una acción: Ciudad País Crear certificado de cliente Plataforma actual:  Departamento (OU) VERITECH: Administrador gráfico en consola de OpenVPN Creando el ambiente para easy-rsa:

 * Creando /etc/openvpn/easy-rsa
 * Copiando easy-rsa
 * Respaldando vars a ./data/backup Configurando easy-rsa Correo electrónico Borrar y recrear el certificado del servidor Salir Primera ejecución, arreglando el ambiente ¿Quieres agregar otra ruta? ¿Otra ruta? Ingrese el nombre de su ciudad: Ciudad Seleccione el código de su país: País Seleccione el tipo de dispositivo a usar: Tipo de dipositivo Ingrese la dirección IP del servidor DNS que usarán los clientes: Opción DNS Ingrese su correo electrónico: Correo electrónico Se utilizará el túnel VPN para enviar todo el tráfico? Gateway por defecto Seleccione el tamaño de llave. Recuerde: Mientras más grande la llave, más segura, pero también más lento. Tamaño de llave Ingrese el nombre de su organización: Organización Ingresa tu departamento (OU): Unidad Organizacional Ingresa el puerto que tu servidor usará, el estándar es 1194 Puerto Selecciona el protocolo a utilizar: Protocolo Ingrese el nombre de su Provincia: Provincia Ingresa el nombre FQDN o al dirección IP de tu servidor: Ingresa las ips dinámicas a asignar, usa la siguiente notación (ip-inicial ip-final máscara): 10.1.0.2 10.1.0.100 255.255.255.0 Red del servidor Dirección del servidor Ingresa una red que el túnel aceptará: 10.1.0.0 255.255.255.0 Rutas estáticas Usuario habilitó debug Opción desconocida Tamaño de llave Menú principal Modificar la configuración del servidor (No hay cambios a los certificados) Hacen falta dependencias, se instalarán No tiene permisos de superusuario Organización Provincia Creando el certificado del servidor:

 * Borrando otros certificados
 * Creando CA
 * Creando llave del servidor
 * Creando Delfie Hellman

Esto puede demorar... Certificado de servidor creado exitosamente, puedes encontrarlo en: /etc/openvpn/easy-rsa/keys Certificado del servidor Dispositivo del servidor Gateway del servidor IP del servidor Nombre del servidor (IP) Pool de direcciones Puerto del servidor Protocolo del servidor Rutas del servidor Versión de sistema no soportada Plataforma no soportada:  Por favor valide los datos ingresados Validación de datos VPN como gateway por defecto Bienvenido a VERITECH, un administrador sencillo para servidores OpenVPN.
Con Veritech podrás:
 * Instalar
 * Configurar
 * Administrar
 un servidor OpenVPN desde la línea de comandos.

¿Quieres continuar? Bienvenido Nombre de ciudad muy corto o con caractéres especiales Datos incorrectos Dirección de servidor DNS errónea, sólo las direcciones IPv4 son soportadas. Correo electrónico inválido, verifique Nombre de organización muy corto o con caractéres especiales Nombre de departamento muy corto o con caractéres especiales Ingresaste un puerto incorrecto, recuerda que puedes usar desde el 1 al 65535. Nombre de provincia muy corto o con caractéres especiales El nombre o la dirección IP de tu servidor es incorrecto, recuerda usar un FQDN o una dirección IPv4. Notación de red de servidor equivocada, usa algo como: 172.16.32.0 255.255.255.0 Su Ciudad IP de tu servidor DNS mi@email.com Su organización Sistemas Su provincia Nombre de tu servidor 